class Builders::Registry::ShareBuilder
  class << self
    def create(submission, vessel, _approval_params)
      @submission = submission
      @vessel = vessel

      perform

      @vessel.reload
    end

    private

    def perform
      @vessel.shareholder_groups.destroy_all

      @submission.declaration_groups.each do |declaration_group|
        shareholder_group =
          @vessel.shareholder_groups.create(
            shares_held: declaration_group.shares_held)

        declaration_group.declaration_group_members.each do |dec_group_member|
          shareholder_group.shareholder_group_members.create(
            owner_id: dec_group_member.declaration_owner.registered_owner_id)
        end
      end
    end
  end
end
