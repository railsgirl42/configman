FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user#{n}" }
    password "foobar"
    password_confirmation { password }
    email { "#{username.gsub(' ','')}@example.com".downcase }
  end
end
