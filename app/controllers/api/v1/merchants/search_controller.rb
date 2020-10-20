class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_by('name ILIKE ?', "%#{params[:name].downcase}%")
    render json: MerchantSerializer.new(merchant)
  end
end
