module CategoriesHelper

  def category_tree(roots=Category.roots, ret=[])
    roots.each do |root|
      ret << [root.ancestors.size, root]
      unless root.children.empty? then
        ret = category_tree(root.children, ret)
      end
    end
    ret
  end

  def options_for_category_tree(roots=Category.roots)
    ret = []
    category_tree(roots).each do |depth,category|
      caption = '-'*depth
      caption += category.name
      ret << [caption, category.id]
    end
    ret
  end
  
end
