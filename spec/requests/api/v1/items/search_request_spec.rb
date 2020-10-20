require 'rails_helper'

RSpec.describe 'ITEM API SEARCH' do
  describe 'single-finder' do
    describe 'item name' do
      before :each do
        create_list(:item, 3)
      end

      describe 'happy' do
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
          expect(@json[:data][:attributes][:name]).to be_a(String)
          expect(@json[:data][:attributes]).to have_key(:description)
          expect(@json[:data][:attributes][:description]).to be_a(String)
          expect(@json[:data][:attributes]).to have_key(:unit_price)
          expect(@json[:data][:attributes][:unit_price]).to be_a(Float)
          expect(@json[:data][:attributes]).to have_key(:merchant_id)
          expect(@json[:data][:attributes][:merchant_id]).to be_a(Integer)
        end

        it 'returns a single item by searching for full name' do
          get '/api/v1/items/find?name=MyString'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial name - lower case' do
          get '/api/v1/items/find?name=ring'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial name - upper case' do
          get '/api/v1/items/find?name=RING'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial name - mixed' do
          get '/api/v1/items/find?name=myS'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end
      end

      describe 'sad' do
        it 'returns 204 if no match found' do
          get '/api/v1/items/find?name=blonde'
          expect(response).to be_successful
          expect(response.status).to eq(204)
        end
      end
    end

    describe 'item description' do
      before :each do
        create_list(:item, 3)
      end

      describe 'happy' do
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
          expect(@json[:data][:attributes][:name]).to be_a(String)
          expect(@json[:data][:attributes]).to have_key(:description)
          expect(@json[:data][:attributes][:description]).to be_a(String)
          expect(@json[:data][:attributes]).to have_key(:unit_price)
          expect(@json[:data][:attributes][:unit_price]).to be_a(Float)
          expect(@json[:data][:attributes]).to have_key(:merchant_id)
          expect(@json[:data][:attributes][:merchant_id]).to be_a(Integer)
        end
        
        it 'returns a single item by searching for full description' do
          get '/api/v1/items/find?description=MyString'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial description - lower case' do
          get '/api/v1/items/find?description=ring'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial description - upper case' do
          get '/api/v1/items/find?description=RING'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a single item by searching for partial description - mixed' do
          get '/api/v1/items/find?description=myS'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end
      end

      describe 'sad' do
        it 'returns 204 if no match found' do
          get '/api/v1/items/find?description=blonde'
          expect(response).to be_successful
          expect(response.status).to eq(204)
        end
      end
    end
  end
end
