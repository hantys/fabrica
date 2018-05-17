require 'rails_helper'

RSpec.describe "Hits", type: :request do
  describe "GET /hits" do
    it "works! (now write some real specs)" do
      get hits_path
      expect(response).to have_http_status(200)
    end
  end
end
