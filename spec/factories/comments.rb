Factory.define :valid_comment , :class => Comment do |c|
  c.author "test"
  c.comment "bla bla la"
  c.product {|c| c.association(:valid_user) }
  
end

Factory.define :invalid_comment , :class => Comment do |c|
end
