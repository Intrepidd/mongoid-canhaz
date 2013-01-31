require 'test/unit'
require 'mongoid'
require 'rails-mongoid-canhaz'
require 'models/test_object'
require 'models/test_subject'

class TestCanhaz < Test::Unit::TestCase
  def test_methods
    assert_equal true, TestObject.respond_to?(:acts_as_canhaz_object)
    assert_equal true, TestSubject.respond_to?(:acts_as_canhaz_subject)

    assert_equal true, TestObject.respond_to?(:acts_as_canhaz_subject)
    assert_equal true, TestSubject.respond_to?(:acts_as_canhaz_object)

    object = TestObject.new
    subject = TestSubject.new

    assert_equal true, object.canhaz_object?
    assert_equal false, object.canhaz_subject?
    assert_equal false, subject.canhaz_object?
    assert_equal true, subject.canhaz_subject?

  end
end
