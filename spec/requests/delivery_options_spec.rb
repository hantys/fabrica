require 'rails_helper'

RSpec.describe "DeliveryOptions", type: :request do
  describe "GET /delivery_options" do
    it "works! (now write some real specs)" do
      get delivery_options_path
      expect(response).to have_http_status(200)
    end
  end
end
