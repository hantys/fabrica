class ReportsController < ApplicationController
  authorize_resource class: false

  def daily_production

    order_by = "products.name asc"
    @employee = nil
    @client = nil
    merge_where = {status: 2}

    if params[:q]
      if params[:q][:s]
        order_by = params[:q][:s]
      end
      @employee = params[:q][:budget_products_budget_employee_id_in].drop(1)
      @client = params[:q][:budget_products_budget_client_id_in].drop(1)
      params[:q][:budget_products_budget_employee_id_in] = ''
      params[:q][:budget_products_budget_client_id_in] = ''
    end

    @q = Product.ransack(params[:q])

    if @client.present?
      merge_where[:client_id] = @client
    end
    if @employee.present?
      merge_where[:employee_id] = @employee
    end


    @products = @q.result.left_joins(budget_products: [:budget]).where(budgets: merge_where).select("array_agg(distinct(budgets.id)) as budgets_ids, sum(budget_products.qnt) as qnt_pedidos", "(sum(budget_products.qnt) - products.qnt) as para_produzir", "count(budget_products.product_id) as total_produto", "products.*").group("budget_products.product_id", "products.id", "products.name", "products.cod").having("(sum(budget_products.qnt) - products.qnt) > ?", 0).order(order_by)
  end

end
