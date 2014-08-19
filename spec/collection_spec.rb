require 'spec_helper'

describe 'Collection' do

  describe "initialize" do
    it "initializes an collection with a hash" do
      test_collection = Collection.new(ATTRIBUTES)
      expect(test_collection).to be_a Collection
      expect(test_collection.name).to eq 'Nuatu'
    end
  end

  describe "save" do
    it "saves a collection in the database" do
      test_category = Collection.new(ATTRIBUTES)
      test_category.save
      expect(Collection.all).to eq [test_category]
    end
  end

  describe ".all" do
    it "returns all collections" do
      test_collection = Collection.new(ATTRIBUTES)
      test_collection.save
      test_collection1 = Collection.new(ATTRIBUTES)
      test_collection1.save
      expect(Collection.all).to eq [test_collection, test_collection]
    end
  end

  describe ".exist?" do
    it "returns true if the collections exists in the collection table" do
      test_collection = Collection.new(ATTRIBUTES)
      test_collection.save
      expect(Collection.exist?('Nuatu')).to eq true
    end
  end

  describe "==" do
    it "sets two objects as equal if their values are equal" do
      test_collection = Collection.new(ATTRIBUTES)
      test_collection.save
      test_collection1 = Collection.new(ATTRIBUTES)
      test_collection1.save
      expect(test_collection).to eq test_collection1
    end
  end

  describe "update_name" do
    it "update collection name" do
      test_collection = Collection.new(ATTRIBUTES)
      test_collection.save
      test_collection.update_name("Mary")
      expect(test_collection.name).to eq "Mary"
    end
  end

  describe "delete" do
    it "deletes a collection from the database" do
      test_collection = Collection.new(ATTRIBUTES)
      test_collection.save
      test_collection.delete
      expect(Collection.all).to eq []
    end
  end

   describe "artists" do
    it "returns all artist objects associated with collection object" do
      test_collection = Collection.new(ATTRIBUTES); test_collection.save
      test_artist = Artist.new(ATTRIBUTES); test_artist.save
      test_artist1 = Artist.new(ATTRIBUTES); test_artist1.save
      test_artist2 = Artist.new(ATTRIBUTES); test_artist2.save
      test_artist1.update_name("Mary")
      test_artist2.update_name("Andrew")
      test_tape = Tape.new('title' => 'AAA', 'year' => '2012', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist.id.to_s); test_tape.save
      test_tape1 = Tape.new('title' => 'BBB', 'year' => '2013', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist1.id.to_s); test_tape1.save
      test_tape2 = Tape.new('title' => 'CCC', 'year' => '2014', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist2.id.to_s); test_tape2.save
      expect(test_collection.artists).to eq [test_artist, test_artist1, test_artist2]
    end
  end

  describe "tapes" do
    it "returns all tape objects associated with collection object" do
      test_collection = Collection.new(ATTRIBUTES); test_collection.save
      test_artist = Artist.new(ATTRIBUTES); test_artist.save
      test_artist1 = Artist.new(ATTRIBUTES); test_artist1.save
      test_artist2 = Artist.new(ATTRIBUTES); test_artist2.save
      test_artist1.update_name("Mary")
      test_artist2.update_name("Andrew")
      test_tape = Tape.new('title' => 'AAA', 'year' => '2012', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist.id.to_s); test_tape.save
      test_tape1 = Tape.new('title' => 'BBB', 'year' => '2013', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist1.id.to_s); test_tape1.save
      test_tape2 = Tape.new('title' => 'CCC', 'year' => '2014', 'collection_id' => test_collection.id.to_s, 'artist_id' => test_artist2.id.to_s); test_tape2.save
      binding.pry
      expect(test_collection.tapes).to eq [test_tape, test_tape1, test_tape2]
    end
  end

end
