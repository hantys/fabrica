require 'rails_helper'

RSpec.describe "TypeOfPayments", type: :request do
  describe "GET /type_of_payments" do
    it "works! (now write some real specs)" do
      get type_of_payments_path
      expect(response).to have_http_status(200)
    end
  end
end
