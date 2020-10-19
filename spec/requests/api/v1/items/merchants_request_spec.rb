require 'rails_helper'

RSpec.describe 'ITEMS MERCHANT API' do
  it 'returns a merchant for that item' do
    create(:item)

    get "/api/v1/items/#{Item.last.id}/merchant"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    merchant = json[:data]

    expect(merchant[:id]).to eq(Merchant.last.id.to_s)
  end
end
