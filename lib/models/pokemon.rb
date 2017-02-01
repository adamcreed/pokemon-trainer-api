require 'rubygems'
require 'data_mapper'
require_relative 'trainer'

class Pokemon
  include DataMapper::Resource
  storage_names[:default] = "pokemon"

  property :id,             Serial
  property :name,           String
  property :level,          Integer
  property :gender,         String
  property :hp,             Integer
  property :atk,            Integer
  property :def,            Integer
  property :sp_atk,         Integer
  property :sp_def,         Integer
  property :spd,            Integer
  property :nature,         String
  property :ability,        String
  property :hidden_ability, String
  property :moves,          String

  belongs_to :trainer
end

def main
  DataMapper.setup(:default, 'postgres://adamreed:@localhost/pokemon')

  DataMapper.finalize
  DataMapper.auto_migrate!
end

main if __FILE__ == $PROGRAM_NAME
