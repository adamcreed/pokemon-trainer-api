require 'rubygems'
require 'data_mapper'
require_relative 'pokemon'

class Trainer
  include DataMapper::Resource

  property :id,            Serial
  property :name,          String
  property :pokemon_one,   Integer
  property :pokemon_two,   Integer
  property :pokemon_three, Integer
  property :pokemon_four,  Integer
  property :pokemon_five,  Integer
  property :pokemon_six,   Integer

  has n, :pokemon, constraint: :destroy
end

def main
  DataMapper.setup(:default, 'postgres://adamreed:@localhost/pokemon')

  DataMapper.finalize
  DataMapper.auto_migrate!
end

main if __FILE__ == $PROGRAM_NAME
