class ReportsController < ApplicationController
  skip_authorization_check

  def daily_production
    @q = Product.ransack(params[:q])
    @products = @q.result.order(:name)
  end

end
