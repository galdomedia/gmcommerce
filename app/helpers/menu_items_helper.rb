module MenuItemsHelper
  def generate_url_for_menu_item(menu_item)
    return page_url(menu.page) unless menu.page.blank?
    menu.url
  end
end
