class Admin::TasksController < InternalPagesController
  def index
    @tasks = Task.default_task_types.map { |t| Task.new(t[1]) }
  end
end
