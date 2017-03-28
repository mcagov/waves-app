require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe "test_email" do
    let(:mail) { NotificationMailer.test_email("test@example.com") }

    it "renders the headers" do
      expect(mail.subject).to match(/Message from the MCA/)
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq([ENV.fetch("EMAIL_FROM")])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/MCA test email/)
    end
  end

  describe "outstanding_declaration" do
    let(:mail) do
      NotificationMailer.outstanding_declaration(
        default_params, "declaration_id",
        "Jolly Roger", "Bob")
    end

    let(:body) { mail.body.encoded }

    it "renders the headers" do
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq([ENV.fetch("EMAIL_FROM")])
    end

    it "renders the name" do
      expect(body).to match(/Dear Alice/)
    end

    it "renders the declaration_url" do
      expect(body)
        .to include("/referral/outstanding_declaration/declaration_id")
    end

    it "renders the vessel name" do
      expect(body).to match(/with the name Jolly Roger/)
    end

    it "renders the correspondent name" do
      expect(body).to match(/made by Bob/)
    end
  end

  describe "application_receipt" do
    let(:mail) do
      NotificationMailer.application_receipt(
        default_params, "Jolly Roger", "Ref_no",
        declarations_required, :new_registration)
    end

    let(:body) { mail.body.encoded }

    context "when declarations_required" do
      let(:declarations_required) { true }

      it "renders the vessel name" do
        expect(body).to match(/vessel Jolly Roger/)
      end

      it "renders the submission_ref_no" do
        expect(body).to match(/Application Reference No: Ref_no/)
      end

      it "renders the declarations text" do
        expect(body).to match(/#{declaration_text}/)
      end
    end

    context "when declarations are NOT required" do
      let(:declarations_required) { false }

      it "renders the vessel name" do
        expect(body).to match(/vessel Jolly Roger/)
      end

      it "renders the submission_ref_no" do
        expect(body).to match(/Application Reference No: Ref_no/)
      end

      it "does not enders the declarations text" do
        expect(body).not_to match(/#{declaration_text}/)
      end
    end
  end

  describe "application_receipt templates are present" do
    it "renders for each task type" do
      Task.default_task_types.each do |task|
        next unless Task.new(task[1]).emails_application_receipt?
        mail =
          NotificationMailer.application_receipt(
            default_params, "Jolly Roger", "Ref_no", false, task[1])

        expect(mail.body.encoded).to match(/Jolly Roger/)
      end
    end
  end

  describe "application_approval templates are present" do
    it "renders for each task type" do
      Task.default_task_types.each do |task|
        next unless Task.new(task[1]).emails_application_approval?
        mail =
          NotificationMailer.application_approval(
            default_params, "Reg_no", "Bob", task[1], "MV Boat")

        expect(mail.body.encoded).to match(/Dear Alice/)
      end
    end
  end

  describe "application_approval" do
    let(:mail) do
      NotificationMailer.application_approval(
        default_params, "Reg_no",
        "Sally SSR", :new_registration, "My boat", "an_attachment")
    end

    let(:body) { mail.body.encoded }

    it "renders the reg no" do
      expect(body).to match(/your vessel is Reg_no/)
    end

    it "renders the certificate_attached message" do
      expect(body).to match(/attached a copy of your certificate/)
    end

    it "renders the actioned_by signature" do
      expect(body).to match(/Sally SSR/)
    end

    it "renders the phone number" do
      expect(body).to match(/02920 448813/)
    end
  end

  describe "wysiwyg" do
    let(:mail) do
      NotificationMailer.wysiwyg(
        default_params, "Some text", "Sally SSR")
    end

    let(:body) { mail.body.encoded }

    it "renders the body" do
      expect(body).to match(/Some text/)
    end

    it "renders the actioned_by signature" do
      expect(body).to match(/Sally SSR/)
    end

    it "renders the phone number" do
      expect(body).to match(/02920 448813/)
    end
  end

  describe "carving_and_marking_note" do
    let(:mail) do
      NotificationMailer.carving_and_marking_note(
        default_params, 100.0, "Sally SSR", "an_attachment")
    end

    let(:body) { mail.body.encoded }

    it "renders the body" do
      expect(body).to match(/Carving and Marking Note/)
    end
  end
end

def default_params
  {
    subject: "subject",
    to: "test@example.com",
    name: "Alice",
    department: Department.new(:part_3, ""),
  }
end

def declaration_text
  "until all declarations have been received"
end
