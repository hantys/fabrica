class HomeController < ApplicationController
  skip_authorization_check
  def index
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

  def find_payment
    payments = SubTypePayment.where(type_of_payment_id: params[:id]).select(:id, :name).order(:name)

    render json: payments
  end

  def find_delivery
    deliveries = SubDeliveryOption.where(delivery_option_id: params[:id]).select(:id, :name).order(:name)

    render json: deliveries
  end

end
