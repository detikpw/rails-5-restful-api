require 'rails_helper'

RSpec.describe AuthorizeRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => "Bearer #{token_generator(user.id)}" } }
  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  describe '#perform' do
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.perform
        expect(result[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.perform }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => "Bearer #{token_generator(5)}")
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.perform }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => "Bearer #{expired_token_generator(user.id)}" } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect { request_obj.perform }
            .to raise_error(
              ExceptionHandler::ExpiredSignature,
              /Signature has expired/
            )
        end
      end

      context 'fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request_obj.perform }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end