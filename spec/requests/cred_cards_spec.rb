require 'rails_helper'

RSpec.describe "CredCards", type: :request do
  describe "GET /cred_cards" do
    it "works! (now write some real specs)" do
      get cred_cards_path
      expect(response).to have_http_status(200)
    end
  end
end
