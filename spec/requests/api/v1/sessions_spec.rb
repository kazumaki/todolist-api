require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /sessions" do
    let(:valid_user) { User.create(email: 'mail@mail.com', password: 'meme123', password_confirmation: 'meme123')}

    context 'when the user data is valid' do
      before { post '/api/v1/sessions', params: { user: { email: valid_user.email, password: 'meme123' } } }

      it 'responds with a valid JWT' do
        expect(JWT.decode(json["token"], Rails.application.secrets.secret_key_base)[0]['user_id']).to eq(valid_user.id)
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'when the user data is invalid' do
      before { post '/api/v1/sessions', params: { user: { email: 'mymail@mail.com', password: 'meme123' } } }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
