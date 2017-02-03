require_relative '../models/pokemon'
require 'csv'

class Seed
  def self.pokemon
    CSV.foreach('lib/data/pokemon') do |row|
      Pokemon.create(
        name:           row[0],
        nickname:       row[1],
        gender:         row[2],
        level:          row[3],
        hp:             row[4],
        atk:            row[5],
        def:            row[6],
        sp_atk:         row[7],
        sp_def:         row[8],
        spd:            row[9],
        nature:         row[10],
        ability:        row[11],
        hidden_ability: row[12],
        moves:          row[13],
        held_item:      row[14],
        trainer_id:     row[15]
      )
    end
  end
end

Seed.pokemon if __FILE__ == $PROGRAM_NAME
