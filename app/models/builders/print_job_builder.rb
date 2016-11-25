class Builders::PrintJobBuilder
  class << self
    def create(registration, part, templates)
      @registration = registration
      @templates = templates
      @part = part

      create_templates if @registration
    end

    private

    def create_templates
      @templates.each do |template|
        PrintJob.create(
          printable: @registration,
          part: @part,
          template: template
        )
      end
    end
  end
end
