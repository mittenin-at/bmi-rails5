Given /^a user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  @user = User.new
  @user.l
  @user.password = password
end
