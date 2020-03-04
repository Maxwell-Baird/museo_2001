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
    assert_equal [], curator.artist
  end
end
