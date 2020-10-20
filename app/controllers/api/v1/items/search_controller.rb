class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:description]
      item = Item.find_by('description ILIKE ?', "%#{params[:description].downcase}%")
      return nil if item == nil
      render json: ItemSerializer.new(item)
    elsif params[:unit_price]
      item = Item.find_by(unit_price: params[:unit_price])
      return nil if item == nil
      render json: ItemSerializer.new(item)
    else #name
      item = Item.find_by('name ILIKE ?', "%#{params[:name].downcase}%")
      return nil if item == nil
      render json: ItemSerializer.new(item)
    end
  end
end
