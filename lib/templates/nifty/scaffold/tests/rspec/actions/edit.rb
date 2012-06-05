  it "edit action should render edit template" do
    get :edit, :id => FactoryGirl.create(:<%= instance_name %>)
    response.should render_template(:edit)
  end
