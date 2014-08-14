require 'spec_helper'

describe 'Artist' do

  describe "initialize" do
    it "initializes an artist with a hash" do
      test_artist = Artist.new(ATTRIBUTES)
      expect(test_artist).to be_a Artist
      expect(test_artist.name).to eq 'Nuatu'
    end
  end

  # describe "save" do
  #   it "saves a artist in the database" do
  #     test_artist = Artist.new(ATTRIBUTES)
  #     test_artist.save
  #     expect(Artist.all).to eq [test_artist]
  #   end
  # end
  #
  # describe ".all" do
  #   it "returns all artists" do
  #     test_artist = Artist.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist1 = Artist.new(ATTRIBUTES)
  #     test_artist1.save
  #     expect(Artist.all).to eq [test_artist, test_artist1]
  #   end
  # end
  #
  # describe "==" do
  #   it "sets two objects as equal if their values are equal" do
  #     test_artist = Artist.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist1 = Artist.new(ATTRIBUTES)
  #     test_artist1.save
  #     expect(test_artist).to eq test_artist1
  #   end
  # end
  #
  # describe "edit_name" do
  #   it "edits artist name" do
  #     test_artist = Artist.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist.edit_name("Mary")
  #     expect(test_artist.name).to eq "Mary"
  #   end
  # end
  #
  # describe "delete" do
  #   it "deletes a artist from the database" do
  #     test_artist = Artist.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist.delete
  #     expect(Artist.all).to eq []
  #   end
  # end
end
