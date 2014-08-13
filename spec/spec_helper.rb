require 'rspec'
require 'pg'
require 'collection'
require 'tape'
require 'pry'

ATTRIBUTES = {'name' => 'Nuatu'}

DB = PG.connect({:dbname => 'tape_organizer_psql_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM collections *;")
    DB.exec("DELETE FROM tapes *;")
  end
end
