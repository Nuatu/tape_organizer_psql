require 'pg'
require 'pry'
require './lib/tape'
require './lib/artist'
require './lib/collection'

DB = PG.connect({:dbname => 'tape_organizer_psql_development'})

def main_menu
  loop do
    system "clear"

    puts "
    T A P E  C O L L E C T I O N
    ____________________________
  /|............................|
 | |:           1980's         :|
 | |:        WHAT YOU GOT      :|
 | |:     ,-.   _____   ,-.    :|
 | |:    ( `)) [_____] ( `))   :|
 |v|:     `-`   ' ' '   `-`    :|
 |||:     ,______________.     :|
 |||.....|::::o::::::o::::|.....|
 |^|....|:::O::::::::::O:::|....|
 |/`----------------------------|
 `.___/ /====/ /=//=/ /====/____/
      `--------------------'
"
    puts "Press '1' CREATE Collection"
    puts "Press '2' EXISTING Collection(s)"
    puts "Press 'x' Exit Program"
    input = gets.chomp
    exit if input == 'x'
    main_menu_selector(input)
  end
end

def main_menu_selector(input)
  if input == '1'
    puts "Collection Name?"
    new_collection_name = gets.chomp.upcase
    if Collection.exist? (new_collection_name)
      puts "\nSorry, that collection already exists"
    else
    newCollection = Collection.new({'name' => new_collection_name})
    newCollection.save
    puts "**SAVED**"
    end
  elsif input == '2'
    if Collection.all.length == 0
      puts "\nSorry, you have no collections"
      puts "\nWhat you waiting on - TIME == MONEY!"
      puts "\nPress '1' CREATE a new Collection"
      puts "Press '2' EXISTING Collection(s)"
      puts "Press 'x' Exit Program"
      input = gets.chomp
      exit if input == 'x'
      main_menu_selector(input)
    else
      puts "\nExisting Collections:"
    end
    Collection.all.each_with_index { |collection, index| puts "#{index + 1}. #{collection.name}" }
    puts "\nWhat collection number you would like to manage?"
    puts "Press 'D' to delete a collection"
    puts "Press 'U' to update a collection name"
    puts "Press 'X' to go back to the Main Menu"
    input = gets.chomp
    if input.downcase == 'd'
      puts "\nCollection number to Delete?"
      delete = gets.chomp.to_i
      Collection.all[delete - 1].delete
      puts "**DELETED**"
    elsif input.downcase == 'u'
      puts "\nCollection number to Update?"
      collection = gets.chomp.to_i
      puts "New Name?"
      name = gets.chomp
      Collection.all[collection - 1].update_name(name)
      puts "**EDITED**"
    end
    input = input.to_i
    unless input == 0 or input > Collection.all.length
      collection_editor(input)
    end
    main_menu
  end
end

def collection_editor(input)
  puts "\nYou're modifiying the collection: #{Collection.all[input - 1].name}\n"
  puts "\nPress '1' to ADD a TAPE"
  puts "Press '2' to DELETE a TAPE"
  puts "Press '3' to LIST all TAPES in this Collection"
  puts "Press '4' to LIST all ARTISTS"
  puts "Press '5' to SEARCH by ARTIST NAME"
  puts "Press '6' to to SEARCH by TAPE TITLE"
  puts "Press 'm' to return to main menu"
  editing_choice = gets.chomp.to_i

  unless (editing_choice == 'm')
    collection_id = Collection.all[input-1].id
    tapes = Collection.all[input-1].tapes
    if editing_choice == 1
      puts "\nArtist?"
      new_artist_name = gets.chomp.upcase
      puts "\nTitle?"
      new_title = gets.chomp.upcase
      puts "\nRelease year?"
      new_year = gets.chomp
      if Artist.exist? (new_artist_name)
        artist_id = DB.exec("SELECT id FROM artists WHERE name = '#{new_artist_name}';").first['id']
      else
        new_artist = Artist.new({'name' => new_artist_name})
        new_artist.save
        artist_id = new_artist.id
      end
      new_tape = Tape.new({'collection_id' => collection_id, 'artist_id' => artist_id, 'title' => new_title, 'year' => new_year})
      new_tape.save
      puts "**SAVED**"
      collection_editor(input)
    elsif editing_choice == 2
      if tapes.length ==0
        puts "\nSorry, there are no tapes in this collection"
        collection_editor(input)
      else
        puts "\nExisting Tapes:"
        tapes.each_with_index { |tape, index| puts "#{index + 1}. #{tape.artist.name} | #{tape.title} | #{tape.year}" }
        puts "\nTape number to delete?"
        choice = gets.chomp.to_i
        tapes[choice-1].delete
        puts "**DELETED**"
        collection_editor(input)
      end
    elsif editing_choice == 3
      if tapes.length ==0
        puts "\nSorry, there are no tapes in this collection"
        collection_editor(input)
      else
        puts "\nExisting Tapes:"
        tapes.each_with_index { |tape, index| puts "#{index + 1}. #{tape.artist.name} | #{tape.title} | #{tape.year}" }
        collection_editor(input)
      end
    elsif editing_choice == 4
      if tapes.length ==0
        puts "\nSorry, there are no artists or tapes in this collection"
        collection_editor(input)
      else
      artists = Collection.all[input-1].artists
      artists1 = []
      artists.each_with_index { |artist, index| artists1 << artist.name }
      artists1.uniq!
      puts "\n"
      artists1.each_with_index { |artist, index| puts "#{index + 1}. #{artist}" }
      collection_editor(input)
      end
    elsif editing_choice == 5
      if tapes.length ==0
      puts "\nSorry, there are no artists or tapes in this collection"
      collection_editor(input)
      else
      puts "\nARTIST to search for?"
      artist = gets.chomp.upcase
      artist_tapes = Collection.all[input-1].artist_search(artist)
      puts "\n"
      artist_tapes.each_with_index { |tape, index| puts "#{index + 1}. #{tape.artist.name} | #{tape.title} | #{tape.year}" }
      collection_editor(input)
      end
    elsif editing_choice == 6
      if tapes.length ==0
      puts "\nSorry, there are no artists or tapes in this collection"
      collection_editor(input)
      else
      puts "\nTAPE TITLE to search for?"
      title = gets.chomp.upcase
      title_tapes = Collection.all[input-1].title_search(title)
      puts "\n"
      title_tapes.each_with_index { |tape, index| puts "#{index + 1}. #{tape.artist.name} | #{tape.title} | #{tape.year}" }
      collection_editor(input)
      end
    end
  end
end
main_menu
