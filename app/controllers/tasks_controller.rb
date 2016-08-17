class TasksController < InternalPagesController

  def unclaimed
    @registrations = Registration.includes([:vessel, :payment]).all
  end

  def mine
  end
end
