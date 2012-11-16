class Admin::UsersController < Admin::AdminController

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = 'Your user information has been successfully updated'
    else
      flash[:error] = @user.errors.full_messages.join('<br/>')
    end

    redirect_to edit_admin_users_path
  end
end