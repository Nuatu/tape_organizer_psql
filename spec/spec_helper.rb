require 'rspec'
require 'pg'
require 'collection'
require 'tape'
require 'artist'
require 'pry'

ATTRIBUTES = {'name' => 'Nuatu', 'title' => 'Notorious', 'year' => '2012', 'collection_id' => '1', 'artist_id' => '1'}

DB = PG.connect({:dbname => 'tape_organizer_psql_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM collections;")
    DB.exec("DELETE FROM tapes;")
    DB.exec("DELETE FROM artists;")
  end
end
