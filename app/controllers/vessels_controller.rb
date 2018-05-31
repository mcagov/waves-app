class VesselsController < InternalPagesController
  def show
    @vessel =
      Decorators::Vessel.new(Register::Vessel
        .includes(preload).find(params[:id]))
  end

  def index
    @vessels =
      Register::Vessel.in_part(current_activity.part)
                      .includes(:current_registration)
                      .paginate(page: params[:page], per_page: 20)
                      .order(:name)
  end

  private

  def preload
    [
      :correspondences, :owners, :registrations, :current_registration,
      :notes, :engines, :beneficial_owners,
      mortgages: [:mortgagees, :mortgagors],
      shareholder_groups: [:shareholder_group_members],
      submissions: [
        :correspondences, :print_jobs,
        { notifications: :notifiable },
        { declarations: :notification }]
    ]
  end
end
