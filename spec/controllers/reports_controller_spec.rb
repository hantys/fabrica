require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #daily_production" do
    it "returns http success" do
      get :daily_production
      expect(response).to have_http_status(:success)
    end
  end

end
