module UsersHelper

  def user_submit_label
    @user.new_record? ? "Sign up" : "Update"
  end
end
