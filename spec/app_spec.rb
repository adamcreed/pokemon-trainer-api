require 'app'
require 'rspec'
require 'rack/test'

describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'get /api/trainers' do
    it 'returns all trainers' do
      get '/api/trainers'

      expect(JSON.parse(last_response.body).first['name']).to eq 'Adam'
    end
  end

  describe 'get /api/trainers/:id' do
    context 'when a trainer exists for the id entered' do
      it 'returns all pokemon for the id provided' do
        get '/api/trainers/1'

        expect(JSON.parse(last_response.body).first['name']).to eq 'Pikachu'
      end
    end
  end
end
