class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if params[:created_at]
      date = Date.parse(params[:created_at])
      merchant = Merchant.where(created_at: date.beginning_of_day..date.end_of_day).first
      return nil if merchant == nil
      render json: MerchantSerializer.new(merchant)
    else
      merchant = Merchant.find_by('name ILIKE ?', "%#{params[:name].downcase}%")
      return nil if merchant == nil
      render json: MerchantSerializer.new(merchant)
    end
  end
end
