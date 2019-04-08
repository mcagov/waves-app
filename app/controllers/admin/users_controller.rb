class Admin::UsersController < InternalPagesController
  before_action :system_manager_only!

  def index
    @users = User.order(:name).paginate(page: params[:page], per_page: 50).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = "Ab1!#{Devise.friendly_token.first(5)}"

    if @user.save
      @user.send_reset_password_instructions
      flash[:notice] = "#{@user.name} has been added to the system"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    load_user
  end

  def update
    load_user

    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.name}'s acount has been updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :access_level, :disabled)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
