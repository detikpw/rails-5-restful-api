require 'rails_helper'

RSpec.describe 'Purchase API', type: :request do
    let!(:products) { create_list(:product, 3) }
    let(:user) { create(:user) }

    # Test GET /purchase
    describe 'POST /purchase' do

        context 'When create purchase' do
            before { post "/purchase", params: { product_ids: products.map(&:id) }.to_json, headers: valid_headers }
            it 'creates a new purchase' do
                expect(response).to have_http_status(201)
            end

            it 'returns success message' do
                expect(json['message']).to match(/Purchase created successfully/)
            end
        end
    end
end