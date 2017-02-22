class Builders::Registry::ShareBuilder
  class << self
    def create(submission, vessel)
      @submission = submission
      @vessel = vessel

      perform

      @vessel
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
            owner_id: dec_group_member.declaration.registered_owner_id)
        end
      end
    end
  end
end
