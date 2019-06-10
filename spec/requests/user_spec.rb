require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
        attributes_for(:user, password_confirmation: user.password)
    end

    describe 'POST /register' do
        context 'when valid request' do
            before { post '/register', params: valid_attributes.to_json, headers: headers }

            it 'creates a new user' do
                expect(response).to have_http_status(201)
            end

            it 'returns success message' do
                expect(json['message']).to match(/Account created successfully/)
            end

            it 'returns an authentication token' do
                expect(json['auth_token']).not_to be_nil
            end
        end

        context 'when invalid request' do
            before { post '/register', params: {}, headers: headers }

            it 'does not create a new user' do
                expect(response).to have_http_status(422)
            end

            it 'returns failure message' do
                expect(json['message'])
                .to match(/Validation failed: Password can't be blank, Username can't be blank, Email can't be blank, Password digest can't be blank/)
            end
        end
    end

    let(:user) { create(:user) }
    let(:username) { user.username }

    describe 'POST /users/#{username}' do
        before { get "/users/#{username}", headers: valid_headers }

        context 'when see the profile page' do
            it 'returns user info' do
                expect(json).not_to be_empty
                expect(json['username']).to eq(username)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:username) { 'mantap_soul' }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end
end