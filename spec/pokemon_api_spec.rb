require 'pokemon_api'
require 'trainers_api'
require 'rspec'
require 'rack/test'
require 'migrate/002_create_pokemon_table'
require 'seed/pokemon'
require 'migrate/001_create_trainers_table'
require 'seed/trainer'

describe 'pokemon_api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :all do
    CreatePokemonTable.migrate(:down)
    CreateTrainersTable.migrate(:down)
    CreateTrainersTable.migrate(:up)
    CreatePokemonTable.migrate(:up)
    Seed.trainers
    Seed.pokemon
  end

  describe '#get /api/pokemon/:name' do
    context 'when a trainer with the pokemon entered exists' do
      it 'returns all trainers that have the searched pokemon' do
        get '/api/pokemon/Pikachu'

        expect(JSON.parse(last_response.body).first['name']).to eq 'Adam'
      end
    end

    context 'when no trainers have pokemon entered' do
      it 'returns a 404 error' do
        get '/api/pokemon/Pumbloom'

        expect(last_response.status).to eq 404
      end
    end
  end

  describe '#post /api/pokemon' do
    context 'when a valid pokemon is created by someone with an empty slot' do
      it 'creates a new pokemon and adds it to a user' do
        params = {
                   name: 'Vulpix', nickname: 'Rokon', gender: 'F', level: 28,
                   hp: 62, atk: 24, def: 23, sp_atk: 32, sp_def: 37, spd: 39,
                   nature: 'Calm', ability: 'Flash Fire',
                   hidden_ability: 'Drought',
                   moves: 'Flame Burst,Confuse Ray,Quick Attack,Ember',
                   held_item: 'Charcoal', trainer_id: 2
                 }

        trainer = Trainer.find(2)

        post '/api/pokemon', params

        expect(last_response.status).to eq 201
        expect(trainer.team.last.name).to eq 'Vulpix'
      end
    end

    context 'when an invalid pokemon is entered' do
      it 'returns an error' do
        params = { name: '' }

        post '/api/pokemon', params

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'No name provided'
      end
    end

    context "when the user's team is full;" do
      it 'returns an error' do
        params = { name: 'Sandslash', trainer_id: 1 }

        post '/api/pokemon', params

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'Team is full'
      end
    end

    context 'when a pokemon is added to a nonexistant user' do
      it 'returns an error' do
        params = { name: 'Sandslash', trainer_id: 99999999 }

        post '/api/pokemon', params

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'Trainer not found'
      end
    end
  end

  describe '#patch /api/pokemon/:id' do
    context 'when a valid ID is entered' do
      it 'updates the pokemon' do
        params = {
                   id: 7, name: 'Vulpix', nickname: 'Pikachu', gender: 'F',
                   level: 28, hp: 62, atk: 24, def: 23, sp_atk: 32, sp_def: 37,
                   spd: 39, nature: 'Calm', ability: 'Flash Fire',
                   hidden_ability: 'Drought',
                   moves: 'Flame Burst,Confuse Ray,Quick Attack,Ember',
                   held_item: 'Charcoal', trainer_id: 2
                 }

        patch '/api/pokemon/7', params

        expect(JSON.parse(last_response.body)['id']).to eq 7
        expect(JSON.parse(last_response.body)['name']).to eq 'Vulpix'
      end
    end

    context 'when an invalid ID is entered' do
      it 'returns a 400' do
        params = {
                   id: 99999, name: 'Vulpix', nickname: 'Pikachu', gender: 'F',
                   level: 28, hp: 62, atk: 24, def: 23, sp_atk: 32, sp_def: 37,
                   spd: 39, nature: 'Calm', ability: 'Flash Fire',
                   hidden_ability: 'Drought',
                   moves: 'Flame Burst,Confuse Ray,Quick Attack,Ember',
                   held_item: 'Charcoal', trainer_id: 2
                 }

        patch '/api/pokemon/99999', params

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'No pokemon found'
      end
    end
  end

  describe '#delete /api/pokemon/:id' do
    context 'when an ID for an existing pokemon is entered' do
      it 'deletes the pokemon' do
        delete '/api/pokemon/37'

        expect(Pokemon.find_by(id: 37)).to eq nil
      end
    end

    context 'when an ID for an non-existing pokemon is entered' do
      it 'returns a 400 error' do
        delete '/api/pokemon/9999999'

        expect(last_response.status).to eq 400
        expect(JSON.parse(last_response.body)).to eq 'No pokemon found'
      end
    end
  end
end
