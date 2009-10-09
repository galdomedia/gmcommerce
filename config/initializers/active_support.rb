module ActiveSupport
  module CoreExtensions
    module String
      module Inflections
        def parameterize(sep = '-')
          Inflector.parameterize(self.gsub("ł", "l").gsub("Ł", "L"), sep)
        end
      end
    end
  end
end
