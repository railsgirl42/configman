require File.dirname(__FILE__) + '/../spec_helper'

describe <%= class_name %> do
  it "should be valid" do
    FactoryGirl.create(:<%= instance_name %>).should be_valid
  end
end
