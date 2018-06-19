class FinancePayments::PaymentsController < InternalPagesController
  def update
    @payment = Payment.find(params[:id])

    if @payment.update_attributes(payment_params)
      flash[:notice] ||=
        "The application has been saved to the unclaimed tasks queue"
      redirect_to tasks_my_tasks_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:submission_id)
  end
end
