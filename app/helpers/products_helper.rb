module ProductsHelper
  def options_for_category_tree(roots, ret=[])
    roots.each do |root|
      caption = '-' * root.ancestors.size
      caption += h(root.name)
      ret << [caption, root.id]
      unless root.children.empty? then
        ret = options_for_category_tree(root.children, ret)
      end
    end
    ret
  end
end
