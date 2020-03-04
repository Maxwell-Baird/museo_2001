require './lib/artist'
require './lib/photograph'
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
  
end
