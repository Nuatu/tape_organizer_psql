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
      test_category = Collection.new(ATTRIBUTES)
      test_category.save
      test_category.delete
      expect(Collection.all).to eq []
    end
  end
end
