require_relative '../environment'
require_relative '../models/trainer'

class CreateTrainersTable < ActiveRecord::Migration[5.0]

  def up
    create_table :trainers do |t|
      t.string     :name
    end
  end

  def down
    drop_table :trainers
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateTrainersTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
