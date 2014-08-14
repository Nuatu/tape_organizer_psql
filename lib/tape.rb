class Tape

  attr_accessor :artist_id, :title, :year
  attr_reader :id

  def initialize(attributes)
    @collection_id = attributes['collection_id']
    @artist_id = attributes['artist_id']
    @title = attributes['title']
    @year = attributes['year']
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
#
#   def ==(another_collection)
#     @name == another_collection.name
#   end
#
#   def edit_name(new_name)
#     DB.exec("UPDATE collections SET name = '#{new_name}' WHERE id = #{@id};")
#     @name = new_name
#   end
#
#   def delete
#     DB.exec("DELETE FROM collections WHERE id = #{@id};")
#   end
#
end
