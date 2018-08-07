class ReportsController < ApplicationController
  authorize_resource class: false

  def daily_production
    @q = Product.ransack(params[:q])

    order_by = "products.name asc"
    if params[:q]
      if params[:q][:s]
        order_by = params[:q][:s]
      end
    end
    @products = @q.result.left_joins(budget_products: [:budget]).where(budgets: {status: 2}).select("sum(budget_products.qnt) as qnt_pedidos", "(sum(budget_products.qnt) - products.qnt) as para_produzir", "count(budget_products.product_id) as total_produto", "products.*").group("budget_products.product_id", "products.id", "products.name", "products.cod").having("(sum(budget_products.qnt) - products.qnt) > ?", 0).order(order_by)
  end

end
