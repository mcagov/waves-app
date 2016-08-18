require "rails_helper"

describe "create submissions via the API", type: :request do
  before { post api_v1_submissions_path, params: params }

  context "with valid params" do
    let(:params) { valid_create_submission_json }
    let(:submission) { Submission.find(json["id"])}
    let(:parsed_body) { JSON.parse(response.body) }

    it "returns the status code :created" do
      expect(response).to have_http_status(:created)
    end

    it "responds with the submission id" do
      expect(parsed_body["data"]["id"]).to be_present
    end

    it "creates a part_3 submission" do
      expect(submission.register.to_sym).to eq(:part_3)
    end

    it "sets the submission#task" do
      expect(submission.task.to_sym).to eq(:new_submission)
    end

    it "sets the due_date"
    it "sets the is_urgent flag"
    it "sets the type"
    it "sets the part"
  end

  context "with invalid params" do
    let(:params) { invalid_create_submission_json }

    it "returns the status code :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

def valid_create_submission_json(changeset="")
  {"data"=>{"type"=>"submissions", "attributes"=>{"register": "part_3","task": "apply_to_register_a_vessel", "changeset"=>changeset, "task"=>"new_submission"}}, "submission"=>{}}
end

def invalid_create_submission_json
  {"data"=>{"type"=>"foobars", "attributes"=>{"task"=>""}}, "submission"=>{}}
end
