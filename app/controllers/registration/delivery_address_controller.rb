class Registration::DeliveryAddressController < Registration::BaseController
  def show
    @delivery_address = DeliveryAddress.new
  end

  def update
    if delivery_address_specified?
      @delivery_address = DeliveryAddress.new(delivery_address_params)

      if @delivery_address.valid?
        store_in_session(:delivery_address, delivery_address_params)
        return redirect_to controller: :declaration, action: :show
      end

      render :show
    else
      redirect_to controller: :declaration, action: :show
    end
  end

  private

  def delivery_address_specified?
    params[:delivery_address].delete(:delivery_address_toggle) == "true"
  end

  def delivery_address_params
    params.require(:delivery_address).permit(
      :address_1,
      :address_2,
      :address_3,
      :town,
      :county,
      :postcode,
      :country
    )
  end
end
