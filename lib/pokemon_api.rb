require 'json'
require 'sinatra'
require 'yaml'
require_relative 'models/pokemon'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

get '/api/pokemon/:name' do |name|
  pokemon = Pokemon.where(name: name)
  if pokemon.blank?
    halt [404, 'No trainers found with that pokemon'.to_json]
  end

    trainers = pokemon.map { |pokemon| Trainer.find(pokemon.trainer_id) }
    trainers.to_json
end

post '/api/pokemon' do
  pokemon = Pokemon.new(params)
  halt [400, 'No name provided'.to_json] unless pokemon.valid?

  trainer = Trainer.find_by(id: pokemon.trainer_id)
  halt [400, 'Trainer not found'.to_json] if trainer.nil?
  halt [400, 'Team is full'.to_json] if trainer.team.size >= 6

  pokemon.save
  [201, pokemon.to_json]
end

patch '/api/pokemon/:id' do |id|
  pokemon = Pokemon.find_by(id: id)
  halt [400, 'No pokemon found'.to_json] if pokemon.nil?

  params.delete('splat')
  params.delete('captures')

  pokemon.update(params)
  pokemon.to_json
end

delete '/api/pokemon/:id' do |id|
  pokemon = Pokemon.find_by(id: id)
  halt [400, 'No pokemon found'.to_json] if pokemon.nil?

  pokemon.destroy
  pokemon.to_json
end
