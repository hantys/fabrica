class ReportsController < ApplicationController
  authorize_resource class: false

  def daily_production
    sql = "select sum(bp.qnt) as qnt_pedidos, p.qnt as qnt_produto, count(bp.product_id) as total_produto, p.name, p.cod from budget_products as bp left join products as p on bp.product_id = p.id left join budgets as b on bp.budget_id = b.id where b.status = 2 group by bp.product_id, bp.qnt, p.qnt, p.name, p.cod"
    @products = ActiveRecord::Base.connection.execute(sql)
  end

end
