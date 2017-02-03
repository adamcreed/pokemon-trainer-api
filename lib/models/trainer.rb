require 'active_record'
require_relative 'pokemon'

class Trainer < ActiveRecord::Base
  has_many :pokemon, dependent: :destroy
  validates :name,
            presence: true

  def team
    Pokemon.where(trainer_id: attributes['id'])
  end
end
