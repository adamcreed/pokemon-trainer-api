require 'active_record'
require_relative 'trainer'

class Pokemon < ActiveRecord::Base
  self.table_name = 'pokemon'
  has_one :trainer
  validates :name,
            presence: true
end
