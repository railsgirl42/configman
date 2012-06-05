  it "show action should render show template" do
    get :show, :id => FactoryGirl.create(:<%= instance_name %>)
    response.should render_template(:show)
  end
