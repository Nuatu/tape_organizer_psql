require 'set'

class Artist

  attr_accessor :name
  attr_reader  :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    output = []
    results = DB.exec("SELECT * FROM artists;")
    results.each do |artist|
      output << Artist.new(artist)
    end
    output
  end

  def save
    @id = DB.exec("INSERT INTO artists(name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end
  #
  # def ==(another_artist)
  #   @name == another_artist.name
  # end
  #
  # def edit_name(new_name)
  #   DB.exec("UPDATE artists SET name = '#{new_name}' WHERE id = #{@id};")
  #   @name = new_name
  # end
  #
  # def delete
  #   DB.exec("DELETE FROM artists WHERE id = #{@id};")
  # end

end
