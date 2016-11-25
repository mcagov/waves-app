class Builders::PrintJobBuilder
  class << self
    def create(registration, templates)
      @registration = registration
      @templates = templates

      create_templates if @registration
    end

    private

    def create_templates
      @templates.each do |template|
        PrintJob.create(
          printable: @registration,
          template: template
        )
      end
    end
  end
end
