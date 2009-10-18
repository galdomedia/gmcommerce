# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Producer.delete_all
ProductVariation.delete_all
Option.delete_all
OptionGroup.delete_all
Property.delete_all
PropertyType.delete_all
ProductTemplate.delete_all
Product.delete_all
Category.delete_all
Role.delete_all
User.delete_all

category_role = Role.create(:name=>"categories")
pages_role = Role.create(:name=>"pages")
users_role = Role.create(:name=>"users")
producers_role = Role.create(:name=>"producers")
products_role = Role.create(:name=>"products")
product_templates_role = Role.create(:name=>"product_templates")
property_types_role = Role.create(:name=>"property_types")

user = User.create(:login=>"admin", :email=>"admin@gmcommerceapp.com", :password=>"administrator", :password_confirmation=>"administrator")
user.is_admin = true
user.is_staff = true
user.roles << category_role
user.roles << pages_role
user.roles << users_role
user.roles << products_role
user.roles << product_templates_role
user.roles << property_types_role
user.roles << producers_role
user.save

category_parent = Category.create(:name=>"test")
category_child = Category.create(:name=>"child", :parent_id=>category_parent.id)
product_simple = Product.create(:name=>"simple", :price=>19.90)
category_child.products << product_simple
product_advanced = Product.create(:name=>"advanced", :price=>199.90)
product_advanced.categories = [category_parent, category_child]
product_advanced.save
pt_string = PropertyType.create(:name=>"string property", :field_type=>"string", :identifier=>"string property")
pt_bool = PropertyType.create(:name=>"bool property", :field_type=>"boolean", :identifier=>"bool property")
pt_text = PropertyType.create(:name=>"text property", :field_type=>"text", :identifier=>"text property")

template = ProductTemplate.create(:template_name=>"all inclusive")
template.property_types << pt_string
template.property_types << pt_bool
template.property_types << pt_text

p1 = Property.create(:product_id=>product_advanced.id, :property_type_id=>pt_string.id)
p2 = Property.create(:product_id=>product_advanced.id, :property_type_id=>pt_bool.id)
p3 = Property.create(:product_id=>product_advanced.id, :property_type_id=>pt_text.id)

og = OptionGroup.create(:name=>"sizes")
option_s = Option.create(:option_group_id=>og.id, :name=>"small", :code=>"s")
option_m = Option.create(:option_group_id=>og.id, :name=>"medium", :code=>"m")
option_l = Option.create(:option_group_id=>og.id, :name=>"large", :code=>"l")
og.options = [option_s, option_m, option_l]
product_advanced.option_groups << og

var1 = product_advanced.new_product_variation
var1.options = [option_s]
var1.price = 170
var1.save

var2 = product_advanced.new_product_variation
var2.options = [option_m]
var2.price = 199.90
var2.save

var3 = product_advanced.new_product_variation
var3.options = [option_l]
var3.price = 219.90
var3.save

appl = Producer.create(:name=>"apple")
appl.products << product_advanced

gateway = Gateway.new
gateway.name = "Platnosci.pl"
gateway.ident = "platnosci_pl"
gateway.is_active = true
gateway.save



