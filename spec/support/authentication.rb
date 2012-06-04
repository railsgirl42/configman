def login_as_user
  activate_authlogic
  UserSession.create FactoryGirl.build(:user)
end
