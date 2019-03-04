require "rails_helper"

describe Admin::ReportsController do
  context "user exports to excel" do
    before do
      sign_in create(:system_manager)

      get :show, params: { id: :cefas, format: :xls }
    end

    it "redirects to the report page" do
      expect(response).to redirect_to("/admin/reports/cefas?")
    end

    it "generates the DownloadableReport", run_delayed_jobs: true do
      expect(DownloadableReport.last.file_file_name).to eq("cefas.xlsx")
    end
  end
end

def default_filters
  { vessel: { name: { value: "", result_displayed: "1" } } }
end
