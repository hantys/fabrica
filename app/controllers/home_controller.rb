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
      cities = City.where(state_id: state.id).select(:id, :name)
      address_full = {bairro: address["bairro"], cep: address["cep"], city: city.id, street: address["end"], id: address["id"], state: state.id, cities: cities }
    end
    render :json => address_full
  end

end
