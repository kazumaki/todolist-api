require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 5) }
  let!(:user_id) { users.first.id }

   # Test suite for GET /user

  describe "GET /users" do
    # make HTTP get request before each example
    before { get '/api/v1/users' }

    it 'return users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /user

  describe 'POST /user' do
    # valid payload
    let(:valid_email) { { email: 'mail@mail.com' } }

    context 'when the request is valid' do
      before { post '/api/v1/users', params: { user: valid_email } }
      it 'creates a user' do
        expect(json['email']).to eq('mail@mail.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { email: '' } }

      it 'returns staus code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(response.body).to include('is too short (minimum is 5 characters)')
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "api/v1/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
