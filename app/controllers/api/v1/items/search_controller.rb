class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by('name ILIKE ?', "%#{params[:name].downcase}%")
    return nil if item == nil
    render json: ItemSerializer.new(item)
  end
end
