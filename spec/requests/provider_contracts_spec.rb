require 'rails_helper'

RSpec.describe "ProviderContracts", type: :request do
  describe "GET /provider_contracts" do
    it "works! (now write some real specs)" do
      get provider_contracts_path
      expect(response).to have_http_status(200)
    end
  end
end
