module MenuItemsHelper
  def generate_url_for_menu_item(menu_item)
    return page_url(menu_item.page) unless menu_item.page.blank?
    menu.url
  end
end
