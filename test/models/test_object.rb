class TestObject
  include Mongoid::Document
  include Rails::Mongoid::Canhaz::Document

  acts_as_canhaz_object

end
