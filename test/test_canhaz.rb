require 'test/unit'
require 'mongoid'
require 'rails-mongoid-canhaz'
require 'models/test_object'
require 'models/test_subject'
require 'init_connection'

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


  def test_can
    object = TestObject.new
    subject = TestSubject.new

    object.save
    subject.save

    assert_equal 0, subject.permissions.size

    subject.can!(:foo, object)

    assert_equal 1, subject.permissions.size

  end

end
