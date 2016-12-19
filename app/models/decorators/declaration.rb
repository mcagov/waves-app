class Decorators::Declaration < SimpleDelegator
  def initialize(declaration)
    @declaration = declaration
    super
  end

  def declaration_required?
    if new_record?
      Task.new(submission.task).declarations_required_on_add_owner?
    elsif not_required?
      false
    else
      true
    end
  end
end
