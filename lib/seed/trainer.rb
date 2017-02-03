require_relative '../environment'
require_relative '../models/trainer'
require 'csv'

class Seed
  def self.trainers
    CSV.foreach('lib/data/trainers') { |row| Trainer.create(name: row[0]) }
  end
end

Seed.trainers if __FILE__ == $PROGRAM_NAME
