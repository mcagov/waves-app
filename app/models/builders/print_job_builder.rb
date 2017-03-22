class Builders::PrintJobBuilder
  class << self
    def create(submission, printable_item, part, templates)
      @submission = submission
      @printable_item = printable_item
      @templates = templates
      @part = part

      create_templates if @printable_item
    end

    private

    def create_templates
      @templates.each do |template|
        PrintJob.create(
          submission: @submission,
          printable: @printable_item,
          part: @part,
          template: template
        )
      end
    end
  end
end
