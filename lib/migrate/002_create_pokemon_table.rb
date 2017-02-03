require_relative '../models/pokemon'

class CreatePokemonTable < ActiveRecord::Migration[5.0]

  def up
    create_table :pokemon do |t|
      t.string     :name
      t.string     :nickname
      t.string     :gender
      t.integer    :level
      t.integer    :hp
      t.integer    :atk
      t.integer    :def
      t.integer    :sp_atk
      t.integer    :sp_def
      t.integer    :spd
      t.string     :nature
      t.string     :ability
      t.string     :hidden_ability
      t.string     :moves
      t.string     :held_item
      t.belongs_to :trainer, foreign_key: 'trainer.id'
    end
  end

  def down
    drop_table :pokemon
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreatePokemonTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
