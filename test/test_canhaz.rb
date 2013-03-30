require 'test/unit'
require 'mongoid'
require 'mongoid-canhaz'
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
    assert_equal false, subject.can?(:foo, object)
    assert_equal true, subject.cannot?(:foo, object)

    assert_equal true, subject.can!(:foo, object)
    assert_equal 1, subject.permissions.size
    assert_equal true, subject.can?(:foo, object)
    assert_equal false, subject.cannot?(:foo, object)

    assert_equal false, subject.can!(:foo, object)
    assert_equal 1, subject.permissions.size

    assert_raise Canhaz::Mongoid::Exceptions::NotACanHazObject do
      subject.can!(:foo, 1)
    end

    assert_equal true, subject.cannot!(:foo, object)
    assert_equal 0, subject.permissions.size
    assert_equal false, subject.can?(:foo, object)

    assert_equal false, subject.can?(:bar)
    assert_equal true, subject.cannot?(:bar)

    assert_equal true, subject.can!(:bar)
    assert_equal false, subject.cannot?(:bar)

    assert_equal false, subject.can!(:bar)

    assert_equal true, subject.cannot!(:bar)

    assert_equal false, subject.can?(:bar)
    assert_equal true, subject.cannot?(:bar)
  end

  def test_objects_with_permission
    subject = TestSubject.new

    o1 = TestObject.new
    o2 = TestObject.new
    o3 = TestObject.new

    subject.save
    o1.save
    o2.save
    o3.save

    assert_equal [], subject.objects_with_permission(TestObject, :foo)

    subject.can!(:foo, o1)
    assert_equal [o1], subject.objects_with_permission(TestObject, :foo)

    subject.can!(:bar, o2)
    assert_equal [o1], subject.objects_with_permission(TestObject, :foo)

    subject.can!(:foo, o3)
    assert_equal [o1, o3], subject.objects_with_permission(TestObject, :foo)

    assert_raise Canhaz::Mongoid::Exceptions::NotACanHazObject do
        subject.objects_with_permission(Fixnum, :foo)
    end
  end

end
