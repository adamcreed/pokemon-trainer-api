require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'pg'
require 'yaml'

namespace :db do

  desc "Migrate the db"
  task :migrate do
    connection_details = ENV['DATABASE_URL']

    if connection_details.blank?
      connection_details = YAML::load(File.open('config/database.yml'))
    end

    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Migrator.migrate("lib/migrate")
  end

  desc "Create the db"
  task :create do
    connection_details = ENV['DATABASE_URL']

    if connection_details.blank?
      connection_details = YAML::load(File.open('config/database.yml'))
    end

    admin_connection = connection_details.merge({'database'=> 'postgres',
                                                'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(connection_details.fetch('database'))
  end

  desc "drop the db"
  task :drop do
    connection_details = ENV['DATABASE_URL']

    if connection_details.blank?
      connection_details = YAML::load(File.open('config/database.yml'))
    end

    admin_connection = connection_details.merge({'database'=> 'postgres',
                                                'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(connection_details.fetch('database'))
  end
end
