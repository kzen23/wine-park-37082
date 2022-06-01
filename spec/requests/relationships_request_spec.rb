require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe 'GET /followed' do
    it 'returns http success' do
      get '/relationships/followed'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /follows' do
    it 'returns http success' do
      get '/relationships/follows'
      expect(response).to have_http_status(:success)
    end
  end
end
