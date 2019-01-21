class HomeController < ApplicationController
  authorize_resource class: false

  def index
    order_by = "products.name asc"
    merge_where = {status: 2}

    @products = Product.left_joins(budget_products: [:budget]).where(budgets: merge_where).select("array_agg(distinct(budgets.id)) as budgets_ids, sum(budget_products.qnt) as qnt_pedidos", "(sum(budget_products.qnt) - products.qnt) as para_produzir", "count(budget_products.product_id) as total_produto", "products.*").group("budget_products.product_id", "products.id", "products.name", "products.cod").having("(sum(budget_products.qnt) - products.qnt) > ?", 0).order(order_by)

    @modal_size = 'lg'

    @bill_payables = BillPayable.includes(:provider_contract).where(status: [0,1]).accessible_by(current_ability).order(id: :desc).limit(20)
  end

  def find_by_address
    api = CorreiosECT::Api.new
    address = api.consulta_cep params[:cep]
    unless address.present?
      address_full = 0
    else
      state = State.where(acronym: address["uf"]).first
      city = City.where(name: address["cidade"]).first
      cities = City.where(state_id: state.id).select(:id, :name).order(:name)
      address_full = {bairro: address["bairro"], cep: address["cep"], city: city.id, street: address["end"], id: address["id"], state: state.id, cities: cities }
    end
    render :json => address_full
  end

  def find_city
    cities = City.where(state_id: params[:id]).select(:id, :name).order(:name)

    render json: cities
  end

  def find_hit
    hit = Hit.find(params[:id]).hit_items.sum(:weight).round(2)

    render json: hit
  end

  def produto_primitivo
    qnt = Product.find(params[:id]).qnt.round(2)

    render json: qnt
  end

  def find_payment
    payments = SubTypePayment.where(type_of_payment_id: params[:id]).select(:id, :name).order(:name)

    render json: payments
  end

  def find_delivery
    deliveries = SubDeliveryOption.where(delivery_option_id: params[:id]).select(:id, :name).order(:name)

    render json: deliveries
  end

end
