require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  render_views

  it "should fail if we are not authenticated" do
    get :index
    response.should_not be_success
  end

  it "index action should render index template" do
    login_as_user
    get :index
    response.should render_template(:index)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(users_path)
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_user).returns(FactoryGirl.create(:user))
    get :edit, :id => FactoryGirl.create(:user)
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => FactoryGirl.create(:user)
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when user is invalid" do
    @controller.stubs(:current_user).returns(FactoryGirl.create(:user))
    user = FactoryGirl.create(:user)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => user
    response.should render_template(:edit)
  end

  it "update action should redirect when user is valid" do
    @controller.stubs(:current_user).returns(FactoryGirl.create(:user))
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FactoryGirl.create(:user)
    response.should redirect_to(users_path)
  end
end
