describe 'trainers_api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '#get /api/trainers' do
    it 'returns all trainers' do
      get '/api/trainers'

      expect(JSON.parse(last_response.body).first['name']).to eq 'Adam'
    end
  end

  describe '#get /api/trainers/:id' do
    context 'when a trainer exists for the id entered' do
      it 'returns all pokemon for the id provided' do
        get '/api/trainers/1'

        expect(JSON.parse(last_response.body).first['name']).to eq 'Gumshoos'
      end
    end

    context 'when a trainer does not exist for the id entered' do
      it 'returns a 404 error' do
        get '/api/trainers/999999999999999999999'

        expect(last_response.status).to eq 404
      end
    end
  end

  describe '#patch /api/trainers/:id' do
    context 'when a valid ID is entered' do
      it 'updates the trainer' do
        params = { id: 3, name: 'Tony Hawk', age: 48, gender: 'M' }

        patch '/api/trainers/7', params

        expect(JSON.parse(last_response.body)['id']).to eq 7
        expect(JSON.parse(last_response.body)['name']).to eq 'Tony Hawk'
      end
    end

    context 'when an invalid ID is entered' do
      it 'returns a 400' do
        params = { id: 3, name: 'Tony Hawk', age: 48, gender: 'M' }

        patch '/api/trainers/99999', params

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'No trainer found'
      end
    end
  end

  describe '#post /api/trainers/:name' do
    context 'when a name is entered' do
      it 'creates a new user' do
        post '/api/trainers/Carl%20Sagan'

        expect(JSON.parse(last_response.body)['name']).to eq 'Carl Sagan'
        expect(Trainer.last.name).to eq 'Carl Sagan'
      end
    end

    context 'when age and gender are provided' do
      it 'creates a new user with age and gender' do
        post '/api/trainers/Carl%20Sagan', { name: 'Carl Sagan', age: 82, gender: 'M'}

        expect(JSON.parse(last_response.body)['age']).to eq 82
        expect(JSON.parse(last_response.body)['gender']).to eq 'M'
        expect(Trainer.last.name).to eq 'Carl Sagan'
      end
    end

    context 'when a name is not entered' do
      it 'returns a 400 error' do
        post '/api/trainers/'

        expect(JSON.parse(last_response.body)).to eq 'No name entered'
        expect(last_response.status).to eq 400
      end
    end
  end

  describe '#delete /api/trainers/:id' do
    context 'when an ID for an existing user is entered' do
      it 'deletes the user' do
        delete '/api/trainers/8'

        expect(Trainer.find_by(id: 8)).to eq nil
      end
    end

    context 'when an ID for an non-existing user is entered' do
      it 'returns a 400 error' do
        delete '/api/trainers/9999999'

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'No trainer found'
      end
    end
  end
end
