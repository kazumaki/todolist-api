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

  describe "GET /users/:id" do
    before { get "/api/v1/users/#{user_id}"}

    it 'return specific user' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(user_id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /user

  describe 'POST /user' do
    # valid payload
    let(:valid_payload) { { email: 'mail@mail.com', password: 'password', password_confirmation: 'password' } }
    
    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_payload }
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

  describe 'PUT /users/:id' do
    let(:valid_token) { JWT.encode(user_id, Rails.application.credentials.secret_key_base.to_s) }
    context 'when there no jwt authentication' do
      before { put "/api/v1/users/#{user_id}", params: { email: 'mail@mail.com' } }

      it 'returns forbidden' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when the payload is valid' do
      before { put "/api/v1/users/#{user_id}", params: { email: 'mail@mail.com' }, headers: {'Authorization': valid_token} }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user updated' do
        expect(json['id']).to eq(user_id)
        expect(json['email']).to eq('mail@mail.com')
      end
    end

    context 'when the payload is invalid' do
      before { put "/api/v1/users/#{user_id}", params: { email: '' } , headers: {'Authorization': valid_token} }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/api/v1/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
