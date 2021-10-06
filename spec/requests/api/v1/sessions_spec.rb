require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe "POST /sessions" do
    let(:valid_user) { User.create(email: 'mail@mail.com', password: 'meme123', password_confirmation: 'meme123')}

    context 'when the user data is valid' do
      before { post '/api/v1/sessions', params: { user: { email: valid_user.email, password: 'meme123' } } }

      it 'responds with a valid JWT' do
        expect { JWT.decode(json["token"], Rails.application.secrets.secret_key_base) }.to_not raise_error(JWT::DecodeError)
      end

      it { expect(response).to have_http_status(:created) }
    end
  end
end
