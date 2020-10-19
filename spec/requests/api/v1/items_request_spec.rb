require 'rails_helper'

RSpec.describe 'ITEM API' do
  it 'sends a list of items' do
    create_list(:item, 5)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items).to be_an(Array)
    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)
      expect(item[:attributes][:description]).to be_an(String)
      expect(item[:attributes][:unit_price]).to be_an(Float)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to be_an(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_an(String)
    expect(item[:attributes][:description]).to be_an(String)
    expect(item[:attributes][:unit_price]).to be_an(Float)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'can create a new item' do
    merchant = create(:merchant)

    item_params = { name: 'Ball',
                    description: 'A basic ball',
                    unit_price: 132.0,
                    merchant_id: merchant.id }
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
  end

  it 'can update an existing item' do
    id = create(:item).id
    previous_name = Item.last.name

    item_params = { name: "Whiffle Ball" }
    headers = {"CONTENT_TYPE" => "application/json"}
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)

    item = Item.find(id)

    expect(response).to be_successful

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
  end
end
