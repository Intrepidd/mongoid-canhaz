class TestObject
  include Mongoid::Document
  include Canhaz::Mongoid::Document

  acts_as_canhaz_object

end
