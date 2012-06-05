  it "destroy action should destroy model and redirect to index action" do
    <%= instance_name %> = FactoryGirl.create(:<%= instance_name %>)
    delete :destroy, :id => <%= instance_name %>
    response.should redirect_to(<%= items_url %>)
    <%= class_name %>.exists?(<%= instance_name %>.id).should be_false
  end
