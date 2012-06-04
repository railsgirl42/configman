require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when authentication is invalid" do
    post :create, :user_session => { :username => "foo", :password => "badpassword" }
    response.should render_template(:new)
    UserSession.find.should be_nil
  end

  it "create action should redirect when authentication is valid" do
    user = FactoryGirl.create( :user, :username => "foo", :password => "secret")
    post :create, :user_session => { :username => "foo", :password => "secret" }
    UserSession.find.user.should == user
    response.should redirect_to(users_path)
  end
end
