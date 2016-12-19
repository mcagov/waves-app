class Decorators::Declaration < SimpleDelegator
  def initialize(declaration)
    @declaration = declaration
    super
  end

  def declaration_required?
    true
  end
end
