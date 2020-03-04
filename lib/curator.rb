require './lib/artist'
require './lib/photograph'
require 'csv'
require 'pry'
class Curator

  attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find{|artist| artist.id == id}
  end

  def photographs_by_artist
    by_artist = {}
    @artists.each do |artist|
      by_artist[artist] = []
      by_artist[artist] << @photographs.find_all do|photograph|
        photograph.artist_id == artist.id
      end
      by_artist[artist] = by_artist[artist].flatten
    end
    by_artist
  end

  def artists_with_multiple_photographs
    artist_with_multiple = []
    photographs_by_artist.each_key do |artist|
      if photographs_by_artist[artist].length > 1
        artist_with_multiple << artist.name
      end
    end
    artist_with_multiple
  end


  def photographs_taken_by_artist_from(country)
    photos = []
    photographs_by_artist.each_key do |artist|
      if artist.country == country
        photos << photographs_by_artist[artist]
      end
    end
    photos.flatten
  end

  def load_photographs(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      photo = Photograph.new({:id => row['id'],:name => row['name'],
        :artist_id => row['artist_id'],:year => row['year']})
      add_photograph(photo)
    end
  end

  def load_artists(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      artist = Artist.new({:id => row['id'],:name=> row['name'],
        :born => row['born'],:died => row['died'], :country => row['country']})
      add_artist(artist)
    end
  end
end
