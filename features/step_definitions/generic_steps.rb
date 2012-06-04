Given /^the following (.+) records:$/ do |factory, table|
  table.hashes.each do |hash|
    FactoryGirl.create(factory, hash)
  end
end

When /^I goto (.+) page$/ do |page_name|
  visit path_to(page_name)
end

When /^I goto edit (.*) for "(.*)" in (.*)$/ do |model, value, field|
  obj = model.camelcase.constantize.find(:first, :conditions => {field.to_sym => value})
  obj = FactoryGirl.create(model.to_sym, field.to_sym => value) if obj.nil?
  visit send("edit_#{model.gsub(" ", "_")}_path",obj)
end

When /^I delete the (\d+)(?:st|nd|rd|th) (.*)$/ do |pos, record|
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

When /^I edit the (\d+)(?:st|nd|rd|th) (.*)$/ do |pos, record|
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Edit"
  end
end

When /^I show the (\d+)(?:st|nd|rd|th) (.*)$/ do |pos, record|
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Show"
  end
end

When /^I attach the "(.*)" file at "(.*)" to "(.*)"$/ do |type, path, field|
  attach_file(field, path, type)
end

Then /^I should see the following (.*)s:$/ do |record, expected_table|
  rows = find("table.listTable").all('tr')
  t = rows.map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/<.+?>/, '').gsub(/\n/, '').gsub(/ +/, ' ').gsub(/\W/,'') } }
  expected_table.diff!(t)
end

Then /^debug page$/ do
  save_and_open_page
end

Then /^I debug$/ do
  breakpoint
  0
end

Then /^pause$/ do
  STDIN.getc
end

After('@pause') do |scenario|
  if scenario.respond_to?(:status) && scenario.status == :failed
    puts "Step Failed. Press Return to close browser"
    STDIN.getc
  end
end


When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should now contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    wait_until {  field_value == value }
  end
end

When /^(?:|I )fill in textfield "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    textfield = find_field(field)
    fill_in(field, :with => value)
    page.driver.browser.execute_script %Q{$("##{textfield['id']}").trigger("change");}
  end
end

When /^I sort by "([^"]*)"(?: within "([^"]*)")?$/ do |column, selector|
  with_scope(selector) do
     click_link(column)
  end
end

