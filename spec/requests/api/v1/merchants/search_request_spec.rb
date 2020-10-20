require 'rails_helper'

RSpec.describe 'MERCHANT API SEARCH' do
  describe 'single-finder' do
    describe 'merchant name' do
      before :each do
        create_list(:merchant, 3)
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

      describe 'sad' do
        it 'returns 204 if no match found', :skip_after do
          get '/api/v1/merchants/find?name=blonde'
          expect(response).to be_successful
          expect(response.status).to eq(204)
        end
      end
    end

    describe 'merchant created_at' do
      before :each do
        create(:merchant, created_at: Date.yesterday)
        create(:merchant, created_at: Date.today)
      end

      it 'returns a single merchant created at specific day' do
        get "/api/v1/merchants/find?created_at=#{Date.yesterday.to_s}"
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to_not be_empty
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to_not be_empty
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)
        expect(json[:data][:attributes]).to have_key(:name)
        expect(json[:data][:attributes]).to_not be_empty
      end

      it 'returns 204 if no date found' do
        get "/api/v1/merchants/find?created_at=#{Date.tomorrow}"
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end
    end

    describe 'merchant updated_at' do
      before :each do
        create(:merchant, created_at: Date.yesterday)
        create(:merchant, created_at: Date.yesterday, updated_at: Date.today)
      end

      it 'returns a single merchant updated at specific day' do
        get "/api/v1/merchants/find?updated_at=#{Date.today.to_s}"
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to_not be_empty
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to_not be_empty
        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)
        expect(json[:data][:attributes]).to have_key(:name)
        expect(json[:data][:attributes]).to_not be_empty
      end

      it 'returns 204 if no date found' do
        get "/api/v1/merchants/find?created_at=#{Date.tomorrow}"
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end
    end
  end

  describe 'multi-finder' do
    describe 'merchant name' do
      before :each do
        create_list(:merchant, 3)
        create(:merchant, name: 'Billy')
      end

      describe 'happy' do
        after :each do
          expect(@json).to have_key(:data)
          expect(@json[:data]).to be_a(Array)
          expect(@json[:data].count).to eq(3)
          expect(@json[:data].first).to have_key(:id)
          expect(@json[:data].first[:id]).to_not be_empty
          expect(@json[:data].first).to have_key(:type)
          expect(@json[:data].first[:type]).to_not be_empty
          expect(@json[:data].first).to have_key(:attributes)
          expect(@json[:data].first[:attributes]).to be_a(Hash)
          expect(@json[:data].first[:attributes]).to have_key(:name)
          expect(@json[:data].first[:attributes]).to_not be_empty
        end

        it 'returns a list of merchants by searching for full name' do
          get '/api/v1/merchants/find_all?name=MyString'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a list of merchants by searching for partial name - lower case' do
          get '/api/v1/merchants/find_all?name=ring'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a list of merchants by searching for partial name - upper case' do
          get '/api/v1/merchants/find_all?name=RING'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end

        it 'returns a list of merchants by searching for partial name - mixed' do
          get '/api/v1/merchants/find_all?name=myS'
          expect(response).to be_successful
          @json = JSON.parse(response.body, symbolize_names: true)
        end
      end

      describe 'sad' do
        it 'returns 204 if no match found', :skip_after do
          get '/api/v1/merchants/find_all?name=blonde'
          expect(response).to be_successful
          expect(response.status).to eq(204)
        end
      end
    end

    describe 'merchant created_at' do
      before :each do
        create(:merchant, created_at: Date.yesterday)
        create(:merchant, created_at: Date.today)
      end

      it 'returns a list of merchants created at specific day' do
        get "/api/v1/merchants/find_all?created_at=#{Date.yesterday.to_s}"
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Array)
        expect(json[:data].count).to eq(1)
        expect(json[:data].first).to have_key(:id)
        expect(json[:data].first[:id]).to_not be_empty
        expect(json[:data].first).to have_key(:type)
        expect(json[:data].first[:type]).to_not be_empty
        expect(json[:data].first).to have_key(:attributes)
        expect(json[:data].first[:attributes]).to be_a(Hash)
        expect(json[:data].first[:attributes]).to have_key(:name)
        expect(json[:data].first[:attributes]).to_not be_empty
      end

      it 'returns 204 if no date found' do
        get "/api/v1/merchants/find_all?created_at=#{Date.tomorrow}"
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end
    end

    describe 'merchant updated_at' do
      before :each do
        create(:merchant, updated_at: Date.yesterday)
        create(:merchant, updated_at: Date.today)
      end

      it 'returns a list of merchants created at specific day' do
        get "/api/v1/merchants/find_all?updated_at=#{Date.yesterday.to_s}"
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Array)
        expect(json[:data].count).to eq(1)
        expect(json[:data].first).to have_key(:id)
        expect(json[:data].first[:id]).to_not be_empty
        expect(json[:data].first).to have_key(:type)
        expect(json[:data].first[:type]).to_not be_empty
        expect(json[:data].first).to have_key(:attributes)
        expect(json[:data].first[:attributes]).to be_a(Hash)
        expect(json[:data].first[:attributes]).to have_key(:name)
        expect(json[:data].first[:attributes]).to_not be_empty
      end

      it 'returns 204 if no date found' do
        get "/api/v1/merchants/find_all?updated_at=#{Date.tomorrow}"
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end
    end
  end
end
