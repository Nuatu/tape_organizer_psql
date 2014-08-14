require 'rspec'
require 'pg'
require 'collection'
require 'tape'
require 'artist'
require 'pry'

ATTRIBUTES = {'name' => 'Nuatu', 'title' => 'Notorious', 'year' => 2012}

DB = PG.connect({:dbname => 'tape_organizer_psql_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM collections *;")
    DB.exec("DELETE FROM tapes *;")
    DB.exec("DELETE FROM artists *;")
  end
end
