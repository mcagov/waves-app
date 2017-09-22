class Admin::CommonMortgageesController < InternalPagesController
  before_action :system_manager_only!

  def index
    @common_mortgagees =
      CommonMortgagee
      .order(:name).paginate(page: params[:page], per_page: 50).all
  end

  def new
    @common_mortgagee = CommonMortgagee.new
  end

  def create
    @common_mortgagee = CommonMortgagee.new(common_mortgagee_params)

    if @common_mortgagee.save
      flash[:notice] = "#{@common_mortgagee.name} has been added to the system"
      redirect_to admin_common_mortgagees_path
    else
      render :new
    end
  end

  def edit
    load_common_mortgagee
  end

  def update
    load_common_mortgagee

    if @common_mortgagee.update_attributes(common_mortgagee_params)
      flash[:notice] = "#{@common_mortgagee.name} has been updated"
      redirect_to admin_common_mortgagees_path
    else
      render :edit
    end
  end

  def destroy
    load_common_mortgagee

    flash[:notice] = "#{@common_mortgagee.name} has been removed"

    @common_mortgagee.destroy
    redirect_to admin_common_mortgagees_path
  end

  private

  def common_mortgagee_params
    params.require(:common_mortgagee).permit(
      Customer.attribute_names,
      common_mortgagee_attributes: Customer.attribute_names + [:_destroy])
  end

  def load_common_mortgagee
    @common_mortgagee = CommonMortgagee.find(params[:id])
  end
end
