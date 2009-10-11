# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
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
