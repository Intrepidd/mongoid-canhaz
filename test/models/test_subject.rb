class TestSubject
  include Mongoid::Document
  include Rails::Mongoid::Canhaz::Document

  acts_as_canhaz_subject

end
