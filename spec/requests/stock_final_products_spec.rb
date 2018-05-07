require 'rails_helper'

RSpec.describe "StockFinalProducts", type: :request do
  describe "GET /stock_final_products" do
    it "works! (now write some real specs)" do
      get stock_final_products_path
      expect(response).to have_http_status(200)
    end
  end
end
