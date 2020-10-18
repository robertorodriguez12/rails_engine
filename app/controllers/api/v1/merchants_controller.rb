class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = { data: Merchant.select("id, name").map do |merchant|
                        {id: merchant.id,
                         type: 'merchant',
                         attributes: {name: merchant.name}}
                      end }

    render json: merchants
  end

  def show
    found = Merchant.find(params[:id])
    merchant = { data: {id: found.id, type: 'found', attributes: {name: found.name}}}

    render json: merchant
  end
end
