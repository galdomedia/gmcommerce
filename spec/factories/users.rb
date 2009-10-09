Factory.define :valid_user , :class => User do |u|
  u.login "tas"
  u.password "tasiu"
  u.password_confirmation "tasiu"
  u.email "tas@gmcommerceapp.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
end

Factory.define :invalid_user , :class => User do |u|
end
