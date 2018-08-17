require 'rails_helper'

RSpec.describe "BillReceivables", type: :request do
  describe "GET /bill_receivables" do
    it "works! (now write some real specs)" do
      get bill_receivables_path
      expect(response).to have_http_status(200)
    end
  end
end
