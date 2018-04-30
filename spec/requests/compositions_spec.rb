require 'rails_helper'

RSpec.describe "Compositions", type: :request do
  describe "GET /compositions" do
    it "works! (now write some real specs)" do
      get compositions_path
      expect(response).to have_http_status(200)
    end
  end
end
