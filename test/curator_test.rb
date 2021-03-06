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

  def test_it_can_find_photographs_by_artist
    curator = Curator.new
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
    photo3 = Photograph.new({
       id: "3",
       name: "Identical Twins, Roselle, New Jersey",
       artist_id: "3",
       year: "1967"
    })
    photo4 = Photograph.new({
       id: "4",
       name: "Monolith, The Face of Half Dome",
       artist_id: "3",
       year: "1927"
    })
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
    artist3 = Artist.new({
       id: "3",
       name: "Diane Arbus",
       born: "1923",
       died: "1971",
       country: "United States"
    })
    curator.add_artist(artist1)
    curator.add_artist(artist2)
    curator.add_artist(artist3)
    curator.add_photograph(photo1)
    curator.add_photograph(photo2)
    curator.add_photograph(photo3)
    curator.add_photograph(photo4)
    expected = {
      artist1 => [photo1],
      artist2 => [photo2],
      artist3 => [photo3, photo4]
    }
    assert_equal expected, curator.photographs_by_artist
  end

  def test_it_can_find_artist_with_multiple_photographs
    curator = Curator.new
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
    photo3 = Photograph.new({
       id: "3",
       name: "Identical Twins, Roselle, New Jersey",
       artist_id: "3",
       year: "1967"
    })
    photo4 = Photograph.new({
       id: "4",
       name: "Monolith, The Face of Half Dome",
       artist_id: "3",
       year: "1927"
    })
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
    artist3 = Artist.new({
       id: "3",
       name: "Diane Arbus",
       born: "1923",
       died: "1971",
       country: "United States"
    })
    curator.add_artist(artist1)
    curator.add_artist(artist2)
    curator.add_artist(artist3)
    curator.add_photograph(photo1)
    curator.add_photograph(photo2)
    curator.add_photograph(photo3)
    curator.add_photograph(photo4)
    assert_equal ["Diane Arbus"], curator.artists_with_multiple_photographs
  end

  def test_it_can_check_photographs_taken_by_artist_from
    curator = Curator.new
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
    photo3 = Photograph.new({
       id: "3",
       name: "Identical Twins, Roselle, New Jersey",
       artist_id: "3",
       year: "1967"
    })
    photo4 = Photograph.new({
       id: "4",
       name: "Monolith, The Face of Half Dome",
       artist_id: "3",
       year: "1927"
    })
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
    artist3 = Artist.new({
       id: "3",
       name: "Diane Arbus",
       born: "1923",
       died: "1971",
       country: "United States"
    })
    curator.add_artist(artist1)
    curator.add_artist(artist2)
    curator.add_artist(artist3)
    curator.add_photograph(photo1)
    curator.add_photograph(photo2)
    curator.add_photograph(photo3)
    curator.add_photograph(photo4)
    assert_equal [photo2, photo3, photo4], curator.photographs_taken_by_artist_from("United States")
    assert_equal [], curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_can_load_photographs
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    assert_equal 4, curator.photographs.length
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
    assert_equal "1", curator.photographs.first.id
    assert_equal "1", curator.photographs.first.artist_id
    assert_equal "1954", curator.photographs.first.year
  end

  def test_it_can_load_artists
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    assert_equal 6, curator.artists.length
    assert_equal '1', curator.artists.first.id
    assert_equal 'Henri Cartier-Bresson', curator.artists.first.name
    assert_equal '1908', curator.artists.first.born
    assert_equal '2004', curator.artists.first.died
    assert_equal 'France', curator.artists.first.country
  end

  def test_it_can_find_photographs_taken_between
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    curator.load_photographs('./data/photographs.csv')
    assert_equal 2, curator.photographs_taken_between(1950..1965).length
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs_taken_between(1950..1965).first.name
    assert_equal "Child with Toy Hand Grenade in Central Park", curator.photographs_taken_between(1950..1965).last.name
  end

  def test_it_can_artist_photographs_by_age
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    curator.load_photographs('./data/photographs.csv')
    diane_arbus = curator.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey",
                39=>"Child with Toy Hand Grenade in Central Park"}
    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end

end
