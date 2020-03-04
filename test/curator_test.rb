require "minitest/autorun"
require "minitest/pride"
require './lib/curator'
require './lib/photograph'
require './lib/artist'

class CuratorTest < Minitest::Test

  def test_it_exist
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_it_has_attributes
    curator = Curator.new
    assert_equal [], curator.photographs
    assert_equal [], curator.artists
  end

  def test_it_can_add_photos
    curator = Curator.new
    assert_equal [], curator.photographs
    photo1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
     })
     photo2 = Photograph.new({
       id: "2",
       name: "Moonrise, Hernandez",
       artist_id: "2",
       year: "1941"
    })
    curator.add_photograph(photo1)
    curator.add_photograph(photo2)
    assert_equal [photo1, photo2], curator.photographs
  end

  def test_it_can_add_artist
    curator = Curator.new
    assert_equal [], curator.artists
    artist1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist1)
    curator.add_artist(artist2)
    assert_equal [artist1, artist2], curator.artists
  end

  def test_it_can_find_artist
    curator = Curator.new
    artist1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist1)
    curator.add_artist(artist2)
    assert_equal artist1, curator.find_artist_by_id("1")
  end
end
