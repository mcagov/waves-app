class SubmissionDeliveryAddressController < InternalPagesController
  before_action :load_submission_and_delivery_address

  def update
    @delivery_address.assign_attributes(delivery_address_params)
    @submission.delivery_address = @delivery_address
    @submission.save

    render json: {
      status: 200,
      inline_name_and_address: @delivery_address.inline_name_and_address,
    }
  end

  protected

  def load_submission_and_delivery_address
    @submission = Submission.find(params[:submission_id])
    @delivery_address = @submission.delivery_address
  end

  def delivery_address_params
    params.require(:delivery_address).permit(
      :name, :address_1, :address_2, :address_3,
      :town, :postcode, :country)
  end
end
