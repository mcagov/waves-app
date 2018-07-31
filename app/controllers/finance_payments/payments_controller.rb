class FinancePayments::PaymentsController < InternalPagesController
  def update
    @payment = Payment.find(params[:id])
    @submission = Submission.find(payment_params[:submission_id])

    if @payment.update_attributes(payment_params)
      flash[:notice] ||=
        "The payment has been linked to this application"
      redirect_to submission_tasks_path(@submission)
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:submission_id)
  end
end
