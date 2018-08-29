require 'rails_helper'

RSpec.describe "CategoryProducts", type: :request do
  describe "GET /category_products" do
    it "works! (now write some real specs)" do
      get category_products_path
      expect(response).to have_http_status(200)
    end
  end
end
