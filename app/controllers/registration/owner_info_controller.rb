class Registration::OwnerInfoController < Registration::BaseController
  def show
    @owner_info = OwnerInfo.new
  end

  def update
    @owner_info = OwnerInfo.new(owner_info_params)

    if @owner_info.valid?
      store_in_session(:owner_info, owner_info_params)
      return redirect_to controller: :delivery_address, action: :show
    end

    render :show
  end

  private

  def owner_info_params
    params.require(:owner_info).permit(
      :title,
      :title_other,
      :first_name,
      :last_name,
      :nationality,
      :address_1,
      :address_2,
      :address_3,
      :town,
      :county,
      :postcode,
      :country,
      :email,
      :phone_number
    )
  end
end
