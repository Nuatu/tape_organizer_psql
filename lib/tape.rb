class Tape

  attr_accessor :collection_id, :artist_id, :title, :year
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
    results = DB.exec("SELECT * FROM tapes;")
    results.each do |result|
      output << Tape.new(result)
    end
    output
  end

  def save
    @id = DB.exec("INSERT INTO tapes (collection_id, artist_id, title, year) VALUES (#{@collection_id}, #{@artist_id}, '#{@title}', '#{year}') RETURNING id;").first['id'].to_i
  end

  def ==(another_tape)
    @collection_id == another_tape.collection_id &&  @artist_id == another_tape.artist_id && @title == another_tape.title && @year == another_tape.year
  end

#   def edit_name(new_name)
#     DB.exec("UPDATE tapes SET name = '#{new_name}' WHERE id = #{@id};")
#     @name = new_name
#   end
#
#   def delete
#     DB.exec("DELETE FROM tapes WHERE id = #{@id};")
#   end
#
end
