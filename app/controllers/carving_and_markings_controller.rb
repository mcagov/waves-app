class CarvingAndMarkingsController < InternalPagesController
  def outstanding
    @submissions =
      Submission
      .outstanding_carving_and_marking
      .paginate(page: params[:page], per_page: 50)
  end

  def mark_as_received
    @submission = Submission.find(params[:id])

    if @submission
      @submission.update_attribute(
        :carving_and_marking_received_at, Time.zone.now)

      flash[:notice] = "Carving & Marking Note has been marked as received"
    end

    redirect_to outstanding_carving_and_markings_path
  end
end
