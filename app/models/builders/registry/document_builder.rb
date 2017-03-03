class Builders::Registry::DocumentBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @submission.documents.each do |submission_document|
        build_document(submission_document)
      end
    end

    def build_document(submission_document)
      vessel_document = @vessel.documents.create(
        actioned_by_id: submission_document.actioned_by_id,
        noted_at: submission_document.noted_at,
        content: submission_document.content,
        issuing_authority: submission_document.issuing_authority,
        expires_at: submission_document.expires_at,
        entity_type: submission_document.entity_type)

      build_assets_for(vessel_document, submission_document)
    end

    def build_assets_for(vessel_document, submission_document)
      submission_document.assets.each do |submission_asset|
        vessel_document.assets.create(file: submission_asset.file)
      end
    end
  end
end
