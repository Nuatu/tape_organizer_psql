require 'set'

class Collection

  attr_accessor :name, :id, :tape_id

  attributes = {'name' => 'name'}

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    output = []
    results = DB.exec("SELECT * FROM collections;")
    results.each do |result|
      output << Collection.new(result)
    end
    output
  end

  def save
    @id = DB.exec("INSERT INTO collections(name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end

  def ==(another_collection)
    @name == another_collection.name
  end

  def edit_name(new_name)
    DB.exec("UPDATE collections SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def delete
    DB.exec("DELETE FROM collections WHERE id = #{@id};")
  end
#
#   def add_tape(new_artist,new_title,new_year)
#     tape_id = DB.exec("INSERT INTO tapes(artist,title,year) VALUES ('#{new_artist}','#{new_title}','#{new_year}') RETURNING id;").first['id'].to_i
#
#   end
#
#   def delete_tape(choice)
#     DB.exec("DELETE FROM tapes where id = '#{@tape_id}';")
#
#   end
#
#   def tapes_list
#     output = "\n"
#     if self.tapes.length == 0
#       output = "This collection has no tapes"
#     else
#       self.tapes.each_with_index do | tape, index |
#         output +="#{index + 1}. #{tape.artist} | #{tape.title} | #{tape.year}\n"
#       end
#     end
#     output
#   end
#
#   def artist_list
#     output = "\n"
#     if self.tapes.length == 0
#       output = "This collection has no tapes"
#     else
#       result = Set.new
#       self.tapes.each do | tape |
#         result.merge([tape.artist])
#       end
#       result.each_with_index do |artist, index|
#         output +="#{index + 1}. #{artist}\n"
#       end
#     end
#     output
#   end
#
#   def artist_search(input)
#     output = "\n"
#     if self.tapes.length == 0
#       output = "This collection has no tapes"
#     else
#       result = Set.new
#       self.tapes.each do | tape |
#         result.merge([[tape.artist, tape.title, tape.year]])
#       end
#       output = result
#       result1 = ""
#       output.each do |tape|
#         if tape[0].downcase == input.downcase
#           result1 += "\nTAPE BY ARTIST: " + tape[0] + ", " + tape[1] + ", " + tape[2].to_s
#         end
#       end
#       if result.length < 1
#         result1 = "\nSorry, this collection doesn't have any tapes by that artist"
#       end
#     end
#     result1
#   end
#
#   def album_search(input)
#     output = "\n"
#     if self.tapes.length == 0
#       output = "This collection has no tapes"
#     else
#       result = Set.new
#       self.tapes.each do | tape |
#         result.merge([[tape.artist, tape.title, tape.year]])
#       end
#       output = result
#       result1 = ""
#       output.each do |tape|
#         if tape[1].downcase == input.downcase
#           result1 = "\nTAPE DETAILS: " + tape[0] + ", " + tape[1] + ", " + tape[2].to_s
#         else
#         result1 = "\nSorry, this collection doesn't include any tapes with that title"
#         end
#       end
#     end
#     result1
#   end
#
end
