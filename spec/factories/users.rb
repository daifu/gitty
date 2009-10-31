Factory.define :valid_user, :class => User do |u|
  u.login "william"
  u.password "william"
  u.password_confirmation "william"
  u.email "william.estoque@gmail.com"
  u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
end

Factory.define :invalid_user, :class => User do |u|
end

Factory.define :user_form, :class => User do |u|
  u.login "joe"
  u.password "plumber"
  u.password_confirmation "plumber"
  u.email "joe.the.plumber@gmail.com"
end