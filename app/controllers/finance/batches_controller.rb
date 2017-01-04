class Finance::BatchesController < InternalPagesController
  def index
    @heading = "All Batches"
    @batches = default_scope
  end

  def this_week
    @heading = "Batches This Week"
    @batches = opened_at_scope(Date.today.beginning_of_week)
    render :index
  end

  def this_month
    @heading = "Batches This Month"
    @batches = opened_at_scope(Date.today.beginning_of_month)
    render :index
  end

  def this_year
    @heading = "Batches This Year"
    @batches = opened_at_scope(Date.today.beginning_of_year)
    render :index
  end

  def create
    @batch =
      FinanceBatch.create(
        opened_at: Time.now,
        processed_by: current_user
      )

    redirect_to new_finance_batch_payment_path(@batch)
  end

  def update
    @batch = FinanceBatch.find(params[:id])
    @batch.toggle_state!

    redirect_to finance_batch_payments_path(@batch)
  end

  def default_scope
    FinanceBatch
      .paginate(page: params[:page], per_page: 20)
      .includes(:finance_payments)
      .order("opened_at desc")
  end

  def opened_at_scope(opened_at)
    default_scope.where("opened_at > ?", opened_at)
  end
end
