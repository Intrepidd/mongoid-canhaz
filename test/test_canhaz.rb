require 'test/unit'
require 'mongoid'
require 'rails-mongoid-canhaz'
require 'models/test_object'
require 'models/test_subject'

class TestCanhaz < Test::Unit::TestCase
  def test_methods
    assert_equal true, Mongoid::Document.respond_to?(:acts_as_canhaz_object)
    assert_equal true, Mongoid::Document.respond_to?(:acts_as_canhaz_subject)
  end
end
