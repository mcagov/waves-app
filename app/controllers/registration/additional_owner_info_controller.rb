class Registration::AdditionalOwnerInfoController < Registration::BaseController
  def show
    @owner_info = AdditionalOwnerInfo.new
  end

  def update
    @owner_info = AdditionalOwnerInfo.new(additional_owner_info)
    if @owner_info.valid?
      store_in_session(:additional_owner_info, owner_info_params)

      if @owner_info.additional_owner == "true"
        return redirect_to controller: :additional_owner_info, action: :show
      else
        return redirect_to controller: :delivery_address, action: :show
      end
    end

    render :show
  end

  private

  def additional_owner_info_params
    params.require(:additional_owner_info).permit(
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
      :phone_number,
      :additional_owner
    )
  end
end
