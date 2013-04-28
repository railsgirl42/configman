class UsersController < ApplicationController
  before_filter :login_required, except: [:new, :create]

  def index
    session[:user_search] = params[:q] if !params[:q].nil? && params[:page].nil?
    session[:user_search] ||= {s: 'username'}
    @search = User.search(session[:user_search])
    @users = @search.result.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = "Thank you for signing up! You are now logged in."
        format.html { redirect_to users_path}
        format.js { render :js => "window.location = '#{users_path}'" }
      else
        format.html {  render 'new' }
        format.js { render 'error' }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: "Your profile has been updated." }
        format.js { render :js => "window.location = '#{users_path}'" }
      else
        format.html { render 'edit' }
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:notice] = "Unable to delete currently logged in user"
    else
      @user.destroy
      flash[:notice] = "Successfully destroyed user."
    end
    redirect_to users_path
  end
end
