require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should succeed creating a new :user from the Factory" do
    FactoryGirl.create(:user)
  end
end
