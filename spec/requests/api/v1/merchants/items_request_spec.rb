require 'rails_helper'

RSpec.describe 'MERCHANT ITEMS API' do
  it 'returns all items for that merchant' do
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id
    create(:item, merchant_id: id_1)
    create(:item, merchant_id: id_1)
    create(:item, merchant_id: id_2)
    create(:item, merchant_id: id_2)

    get "/api/v1/merchants/#{id_1}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items).to be_an(Array)
    expect(items.count).to eq(2)
  end
end
