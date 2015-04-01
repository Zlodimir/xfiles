class Admin::UsersController < Admin::BaseController
  before_action :set_xfiles, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.order(:email)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

    build_roles_for(@user)

  	if @user.save
  		flash[:notice] = "User has been created"
  		redirect_to admin_users_path
  	else
  		flash.now[:alert] = "User not has been created"
  		render "new"
  	end
  end

  def show
  end

  def edit
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You can not delete yourself"
    else
      @user.destroy
      flash[:notice] = "User has been deleted"
    end

    redirect_to admin_users_path
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    User.transaction do
      @user.roles.clear
      build_roles_for(@user)

      if @user.update(user_params)
        flash[:notice] = "User has been updated"
        redirect_to admin_users_path
      else
        flash.now[:alert] = "User has not been updated"
        render "edit"
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def set_xfiles
    @xfiles = Xfile.order(:name)
  end

  def user_params
  	params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def build_roles_for(user)
    role_data = params.fetch(:roles, [])

    role_data.each do | xfile_id, role_name |
      if role_name.present?
        @user.roles.build(xfile_id:  xfile_id, role: role_name)
      end
    end
  end
end
