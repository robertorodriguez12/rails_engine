require 'rails_helper'

RSpec.describe 'MERCHANT API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(Integer)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_an(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end
end
