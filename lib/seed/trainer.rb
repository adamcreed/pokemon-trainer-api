require_relative '../models/trainer'
require 'csv'

class Seed
  def self.trainers
    connection_details = ENV['DATABASE_URL']

    if connection_details.blank?
      connection_details = YAML::load(File.open('config/database.yml'))
    end

    ActiveRecord::Base.establish_connection(connection_details)
    
    CSV.foreach('lib/data/trainers') do |row|
      Trainer.create(
        name: row[0],
        age: row[1],
        gender: row[2]
      )
    end
  end
end

Seed.trainers if __FILE__ == $PROGRAM_NAME
