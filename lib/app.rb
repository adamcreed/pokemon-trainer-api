require 'data_mapper'
require 'json'
require 'sinatra'
require_relative 'models/pokemon'
require_relative 'models/trainer'

DataMapper.setup(:default, 'postgres://adamreed:@localhost/pokemon')

get '/api/trainers' do
  Trainer.all.to_json
end

get '/api/trainers/:id' do |id|
  trainer = Trainer.get(id)
  if trainer.nil?
    [404, 'Error: No trainer found'.to_json]
  else
    pokemon = Pokemon.all(trainer_id: trainer.id)
    pokemon.to_json
  end
end

#   if params['search'].nil? or params['user_id'].nil?
#     pass
#   else
#     completion_filter = params['completed'] || false
#     get_tasks(User.get(params['user_id']).task_users.task
#               .all(:description.like => params['search']),
#               completion_filter).to_json
#   end
# end
#
#
# put '/api/tasks/:id' do |id|
#   task = TaskUser.get(id)
#
#   if task.nil?
#     status 404
#   else
#     complete_task(task)
#   end
# end
#
# post '/api/tasks' do
#   task = create_task(params)
#   list_item = add_task_to_list(task, params)
#
#   { task: task, list_item: list_item }.to_json
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
