module Synthesis
  class AssetPackage

    # class variables
    @@asset_packages_yml = $asset_packages_yml || 
      (File.exists?("#{RAILS_ROOT}/config/asset_packages.yml") ? YAML.load_file("#{RAILS_ROOT}/config/asset_packages.yml") : nil)
  
    # singleton methods
    class << self
      
      def merge_environments=(environments)
        @@merge_environments = environments
      end
      
      def merge_environments
        @@merge_environments ||= ["production"]
      end
      
      def parse_path(path)
        /^(?:(.*)\/)?([^\/]+)$/.match(path).to_a
      end

      def find_by_type(asset_type)
        @@asset_packages_yml[asset_type].map { |p| self.new(asset_type, p, config_for_type(asset_type)) }
      end

      def find_by_target(asset_type, target)
        package_hash = @@asset_packages_yml[asset_type].find {|p| p.keys.first == target }
        package_hash ? self.new(asset_type, package_hash, config_for_type(asset_type)) : nil
      end

      def find_by_source(asset_type, source)
        path_parts = parse_path(source)
        package_hash = @@asset_packages_yml[asset_type].find do |p|
          key = p.keys.first
          p[key].include?(path_parts[2]) && (parse_path(key)[1] == path_parts[1])
        end
        package_hash ? self.new(asset_type, package_hash, config_for_type(asset_type)) : nil
      end

      def targets_from_sources(asset_type, sources)
        package_names = Array.new
        sources.each do |source|
          package = find_by_target(asset_type, source) || find_by_source(asset_type, source)
          package_names << (package ? package.current_file : source)
        end
        package_names.uniq
      end

      def sources_from_targets(asset_type, targets)
        source_names = Array.new
        targets.each do |target|
          package = find_by_target(asset_type, target)
          source_names += (package ? package.sources.collect do |src|
            package.target_dir.gsub(/^(.+)$/, '\1/') + src
          end : target.to_a)
        end
        source_names.uniq
      end

      def lint_all
        @@asset_packages_yml.keys.reject{|key| key == 'config'}.each do |asset_type|
          @@asset_packages_yml[asset_type].each { |p| self.new(asset_type, p, config_for_type(asset_type)).lint }
        end
      end

      def build_all
        @@asset_host = Rails.configuration.action_controller.asset_host
        @@asset_packages_yml.keys.reject{|key| key == 'config'}.each do |asset_type|
          @@asset_packages_yml[asset_type].each { |p| self.new(asset_type, p, config_for_type(asset_type)).build }
        end
      end

      def delete_all
        @@asset_packages_yml.keys.reject{|key| key == 'config'}.each do |asset_type|
          @@asset_packages_yml[asset_type].each { |p| self.new(asset_type, p, config_for_type(asset_type)).delete_previous_build }
        end
      end

      def config_for_type(asset_type)
        if @@asset_packages_yml['config'] && @@asset_packages_yml['config'][asset_type]
          @@asset_packages_yml['config'][asset_type]
        else
          {}
        end
      end

      def create_yml
        unless File.exists?("#{RAILS_ROOT}/config/asset_packages.yml")
          asset_yml = Hash.new

          asset_yml['javascripts'] = [{"base" => build_file_list("#{RAILS_ROOT}/public/javascripts", "js")}]
          asset_yml['stylesheets'] = [{"base" => build_file_list("#{RAILS_ROOT}/public/stylesheets", "css")}]

          File.open("#{RAILS_ROOT}/config/asset_packages.yml", "w") do |out|
            YAML.dump(asset_yml, out)
          end

          log "config/asset_packages.yml example file created!"
          log "Please reorder files under 'base' so dependencies are loaded in correct order."
        else
          log "config/asset_packages.yml already exists. Aborting task..."
        end
      end

    end
    
    # instance methods
    attr_accessor :asset_type, :target, :target_dir, :sources
  
    def initialize(asset_type, package_hash, config = {})
      target_parts = self.class.parse_path(package_hash.keys.first)
      @target_dir = target_parts[1].to_s
      @target = target_parts[2].to_s
      @sources = package_hash[package_hash.keys.first]
      @asset_type = asset_type
      @asset_path = ($asset_base_path ? "#{$asset_base_path}/" : "#{RAILS_ROOT}/public/") +
          "#{@asset_type}#{@target_dir.gsub(/^(.+)$/, '/\1')}"
      @extension = get_extension
      @cache_dir = config['cache_dir'] || ''
      @file_name = File.join(@cache_dir, "#{@target}_packaged.#{@extension}")
      @full_path = File.join(@asset_path, @file_name)
    end
  
    def package_exists?
      File.exists?(@full_path)
    end

    def current_file
      build unless package_exists?

      File.join([@cache_dir, @target_dir, "#{@target}_packaged"].reject{|elem| elem.empty?})
    end

    def build
      delete_previous_build
      create_new_build
    end

    def delete_previous_build
      File.delete(@full_path) if File.exists?(@full_path)
    end
    
    def lint
      yui_path = "#{RAILS_ROOT}/vendor/plugins/asset_packager/lib"
      if @asset_type == "javascripts"
        (@sources - %w(prototype effects dragdrop controls)).each do |s|
          puts "==================== #{s}.#{@extension} ========================"
          system("java -jar #{yui_path}/yuicompressor-2.4.2.jar --type js -v #{full_asset_path(s)} >/dev/null")
          exit($?.exitstatus) unless $?.success?
        end
      end
    end

    private
      def create_new_build
        if File.exists?(@full_path)
          log "Latest version already exists: #{@full_path}"
        else
          Dir.mkdir(File.dirname(@full_path)) unless File.directory?(File.dirname(@full_path))
          File.open(@full_path, "w") {|f| f.write(compressed_file) }
          log "Created #{@full_path}"
        end
      end
      
      def full_asset_path(source)
        "#{@asset_path}/#{source}.#{@extension}"
      end

      def replace_asset_urls(source, data)
        if @asset_type == "stylesheets"
          @@css_url_replacements ||= Hash.new

          matches = data.scan(/url\([\s"']*([^\)"'\s]*)[\s"']*\)/m).collect do |match|
            match.first
          end
          
          # build map of old to new, ensure if 2 files resolve to the same absolute path they get the same asset_host
          matches.uniq.each do |match|
            absolute_path = case match
              when /^(http|https)\:\/\//
                match
              when /^\//
                File.expand_path("#{RAILS_ROOT}/public#{match}")
              else
                File.expand_path(File.join(File.dirname(File.expand_path(source)), match))
              end

              @@css_url_replacements[absolute_path] = case absolute_path
              when /^(http|https)\:\/\//
                absolute_path
              else
                if @@asset_host.class == String
                  host = (@@asset_host =~ /%d/) ? @@asset_host % (absolute_path.hash % 4) : @@asset_host
                  host = host[0..-2] if host =~ /\/$/
                else
                  host = ''
                end

                absolute_path.sub("#{RAILS_ROOT}/public", host) + (File.exist?(absolute_path) ? '?' + File.mtime(absolute_path).to_i.to_s : '')
              end unless @@css_url_replacements.has_key?(absolute_path)

              unless absolute_path == @@css_url_replacements[absolute_path]
                data.gsub!(match, @@css_url_replacements[absolute_path])
              end
          end
        end

        return data
      end

      def merged_file
        merged_file = ""
        @sources.each {|s| 
          File.open(full_asset_path(s), "r") { |f| 
            merged_file += replace_asset_urls(full_asset_path(s), f.read) + "\n" 
          }
        }
        merged_file
      end
    
      def compressed_file
        case @asset_type
          when "javascripts" then compress_js(merged_file)
          when "stylesheets" then compress_css(merged_file)
        end
      end

      def compress_js(source)
        jsmin_path = "#{RAILS_ROOT}/vendor/plugins/asset_packager/lib"
        result = ""
        begin
          # attempt to use YUI compressor
          IO.popen "java -jar #{jsmin_path}/yuicompressor-2.4.2.jar --type js 2>/dev/null", "r+" do |f|
            f.write source
            f.close_write
            result = f.read
          end
          throw "fallback to jsmin below" unless $?.success?
          return result
        rescue
          # fallback to included ruby compressor
          tmp_path = "#{RAILS_ROOT}/tmp/#{@target}_packaged"

          # write out to a temp file
          File.open("#{tmp_path}_uncompressed.js", "w") {|f| f.write(source) }
          `ruby #{jsmin_path}/jsmin.rb <#{tmp_path}_uncompressed.js >#{tmp_path}_compressed.js \n`

          # read it back in and trim it
          result = ""
          File.open("#{tmp_path}_compressed.js", "r") { |f| result += f.read.strip }

          # delete temp files if they exist
          File.delete("#{tmp_path}_uncompressed.js") if File.exists?("#{tmp_path}_uncompressed.js")
          File.delete("#{tmp_path}_compressed.js") if File.exists?("#{tmp_path}_compressed.js")

          return result
        end
      end
  
      def compress_css(source)
        yui_path = "#{RAILS_ROOT}/vendor/plugins/asset_packager/lib"
        result = ""
        begin
          # attempt to use YUI compressor
          IO.popen "java -jar #{yui_path}/yuicompressor-2.4.2.jar --type css 2>/dev/null", "r+" do |f|
            f.write source
            f.close_write
            result = f.read
          end
          return result if $?.success?
        rescue
          source.gsub!(/\/\*(.*?)\*\//m, "") # remove comments - caution, might want to remove this if using css hacks
          source.gsub!(/\s+/, " ")           # collapse space
          source.gsub!(/\} /, "}\n")         # add line breaks
          source.gsub!(/\n$/, "")            # remove last break
          source.gsub!(/ \{ /, " {")         # trim inside brackets
          source.gsub!(/; \}/, "}")          # trim inside brackets
          source
        end
      end

      def get_extension
        case @asset_type
          when "javascripts" then "js"
          when "stylesheets" then "css"
        end
      end
      
      def log(message)
        self.class.log(message)
      end
      
      def self.log(message)
        puts message
      end

      def self.build_file_list(path, extension)
        re = Regexp.new(".#{extension}\\z")
        file_list = Dir.new(path).entries.delete_if { |x| ! (x =~ re) }.map {|x| x.chomp(".#{extension}")}
        # reverse javascript entries so prototype comes first on a base rails app
        file_list.reverse! if extension == "js"
        file_list
      end
   
  end
end
