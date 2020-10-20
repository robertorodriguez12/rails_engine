require 'rails_helper'

RSpec.describe 'MERCHANT API SEARCH' do
  describe 'single-finder' do
    before :each do
      create_list(:merchant, 3)
    end

    after :each do
      expect(@json).to have_key(:data)
      expect(@json[:data]).to be_a(Hash)
      expect(@json[:data]).to have_key(:id)
      expect(@json[:data][:id]).to_not be_empty
      expect(@json[:data]).to have_key(:type)
      expect(@json[:data][:type]).to_not be_empty
      expect(@json[:data]).to have_key(:attributes)
      expect(@json[:data][:attributes]).to be_a(Hash)
      expect(@json[:data][:attributes]).to have_key(:name)
      expect(@json[:data][:attributes]).to_not be_empty
    end

    it 'returns a single merchant by searching for full name' do
      get '/api/v1/merchants/find?name=MyString'
      expect(response).to be_successful
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns a single merchant by searching for partial name - lower case' do
      get '/api/v1/merchants/find?name=ring'
      expect(response).to be_successful
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns a single merchant by searching for partial name - upper case' do
      get '/api/v1/merchants/find?name=RING'
      expect(response).to be_successful
      @json = JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns a single merchant by searching for partial name - mixed' do
      get '/api/v1/merchants/find?name=myS'
      expect(response).to be_successful
      @json = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
