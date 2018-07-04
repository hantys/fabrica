require 'rails_helper'

RSpec.describe "OutOfStocks", type: :request do
  describe "GET /out_of_stocks" do
    it "works! (now write some real specs)" do
      get out_of_stocks_path
      expect(response).to have_http_status(200)
    end
  end
end
