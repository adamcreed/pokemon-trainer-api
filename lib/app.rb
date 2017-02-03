require 'json'
require 'sinatra'
require 'pry'
require_relative 'models/pokemon'
require_relative 'models/trainer'
require_relative '../lib/environment'

get '/api/trainers' do
  Trainer.all.to_json
end

get '/api/trainers/:id' do |id|
  trainer = Trainer.find_by(id: id)
  halt [404, 'No trainer found'.to_json] if trainer.nil?

  trainer.team.to_json
end

get '/api/pokemon/:name' do |name|
  pokemon = Pokemon.where(name: name)
  if pokemon.nil? or pokemon.empty?
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

# put '/api/trainers/:id' do |id|
#   task = TaskUser.get(id)
#
#   if task.nil?
#     status 404
#   else
#     complete_task(task)
#   end
# end

#
# post '/api/users/' do
#   [400, 'Error: No name entered'.to_json]
# end
#
# post '/api/users/:name' do |name|
#   create_user(name)
# end
#
# delete '/api/tasks' do
#   delete_entry(params)
# end
