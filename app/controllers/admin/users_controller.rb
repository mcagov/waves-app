class Admin::UsersController < InternalPagesController
  def index
    @users = User.order(:name).paginate(page: params[:page], per_page: 50).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token.first(8)

    if @user.save
      flash[:notice] = "#{@user.name} has been added to the system"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :access_level)
  end
end
