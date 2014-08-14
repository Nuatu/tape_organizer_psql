require 'spec_helper'

describe 'Tape' do

  describe "initialize" do
    it "initializes a tape with a hash" do
      test_artist = Tape.new(ATTRIBUTES)
      expect(test_artist).to be_a Tape
      expect(test_artist.title).to eq 'Notorious'
    end
  end

  describe "save" do
    it "saves a tape in the database" do
      test_tape = Tape.new(ATTRIBUTES)
      test_tape.save
      expect(Tape.all).to eq [test_tape]
    end
  end

  describe ".all" do
    it "returns all tapes" do
      test_tape = Tape.new(ATTRIBUTES)
      test_tape.save
      test_tape1 = Tape.new(ATTRIBUTES)
      test_tape1.save
      expect(Tape.all).to eq [test_tape, test_tape1]
    end
  end
  #
  # describe "==" do
  #   it "sets two objects as equal if their values are equal" do
  #     test_tape = Tape.new(ATTRIBUTES)
  #     test_tape.save
  #     test_tape1 = Tape.new(ATTRIBUTES)
  #     test_tape1.save
  #     expect(test_tape).to eq test_tape1
  #   end
  # end
  #
  # describe "edit_name" do
  #   it "edits tape name" do
  #     test_artist = Tape.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist.edit_name("Mary")
  #     expect(test_artist.name).to eq "Mary"
  #   end
  # end
  #
  # describe "delete" do
  #   it "deletes a tape from the database" do
  #     test_artist = Tape.new(ATTRIBUTES)
  #     test_artist.save
  #     test_artist.delete
  #     expect(Tape.all).to eq []
  #   end
  # end
end
