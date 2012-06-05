  def index
    session[:<%= instance_name %>_search] = params[:q] if !params[:q].nil? && params[:page].nil?
    session[:<%= instance_name %>_search] ||= {s: ''}
    @search = <%= class_name %>.search(session[:<%= instance_name %>_search])
    @<%= instances_name %> = @search.result.paginate(page: params[:page], per_page: PER_PAGE)
  end
