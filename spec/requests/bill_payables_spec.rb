require 'rails_helper'

RSpec.describe "BillPayables", type: :request do
  describe "GET /bill_payables" do
    it "works! (now write some real specs)" do
      get bill_payables_path
      expect(response).to have_http_status(200)
    end
  end
end
