class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = { data: Merchant.select("id, name").map do |merchant|
                        {id: merchant.id.to_s,
                         type: 'merchant',
                         attributes: {name: merchant.name}}
                      end }

    render json: merchants
  end

  def show
    found = Merchant.find(params[:id])
    merchant = { data: {id: found.id.to_s, type: 'merchant', attributes: {name: found.name}}}

    render json: merchant
  end

  def create
    new = Merchant.create(merchant_params)
    merchant = { data: {id: new.id.to_s, type: 'merchant', attributes: {name: new.name}}}

    render json: merchant
  end

  def update
    found = Merchant.find(params[:id])
    found.update(merchant_params)
    merchant = { data: {id: found.id.to_s, type: 'merchant', attributes: {name: found.name}}}

    render json: merchant
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
