# https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec

require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:user) { create(:user) }


  # Test GET /products
  describe 'GET /products' do

    context 'When with a valid token' do
      before { get '/products', params: {}, headers: valid_headers }
      it 'returns products' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "When with invalid token" do
      before { get '/products', params: {}, headers: invalid_headers }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

  end

end