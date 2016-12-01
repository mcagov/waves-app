class VesselsController < InternalPagesController
  def show
    @vessel =
      Register::Vessel.in_part(current_activity.part)
                      .includes(
                        :correspondences, :owners, :registrations,
                        :current_registration, :notes,
                        submissions: [
                          :correspondences,
                          { notifications: :notifiable },
                          { declarations: :notification }]
                      ).find(params[:id])
  end

  def index
    @vessels =
      Register::Vessel.in_part(current_activity.part)
                      .paginate(page: params[:page], per_page: 20)
                      .order(:name)
  end
end
