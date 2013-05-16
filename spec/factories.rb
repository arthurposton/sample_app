# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name			"Arthur George Poston Jr."
  user.email			"arthur@focuseddevelopment.net"
  user.password			"basketball"
  user.password_confirmation	"basketball"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end