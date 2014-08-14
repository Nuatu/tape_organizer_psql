class Tape

  attr_accessor :artist_id, :title, :year
  attr_reader :id

  def initialize(collection_id,artist_id,title,year)
    @id = attributes['id']
    @artist_id = attributes['artist_id']
    @title = attributes['title']
    @year = attributes['year']
    @collection_id = attributes['collection_id']
  end

end
