# require 'set'
#
class Collection

  attr_accessor :name
  attr_reader  :id

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

  def self.exist? (new_name)
    results = DB.exec("SELECT name FROM collections;")
    results1 = []
    results.each do |x|
      results1 << x['name']
    end
    results1.include? new_name
  end

  def save
    @id = DB.exec("INSERT INTO collections(name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end

  def ==(another_collection)
    @name == another_collection.name
  end

  def update_name(new_name)
    DB.exec("UPDATE collections SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def delete
    DB.exec("DELETE FROM collections WHERE id = #{@id};")
  end

  def artists
    output = []
    results = DB.exec("SELECT artists.* FROM
                       collections JOIN tapes on (collections.id = tapes.collection_id)
                       JOIN artists on (tapes.artist_id = artists.id)
                       WHERE collections.id = #{@id};")
    results.each do |result|
      output << Artist.new(result)
    end
    output
  end

  def tapes
    output = []
    results = DB.exec("SELECT * FROM tapes WHERE collection_id = #{@id};")
    results.each do |result|
      output << Tape.new(result)
    end
    output
  end

  def artist_search(artist_name)
    output = []
    results = DB.exec("SELECT tapes.* FROM
                       artists JOIN tapes on (artists.id = tapes.artist_id)
                       WHERE artists.name = '#{artist_name}';")
    results.each do |result|
      output << Tape.new(result)
    end
    output
  end
end
