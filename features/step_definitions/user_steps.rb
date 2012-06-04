
Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  visit login_path
  fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Log in"
end

Given /^I am logged in as "([^\"]*)"$/ do |username|
  password = "secret"
  FactoryGirl.create(:user, :username => username, :password => password)
  Given "I am logged in as \"#{username}\" with password \"#{password}\""
end

Then /^I should have ([0-9]+) users?$/ do |count|
  User.count.should == count.to_i
end

