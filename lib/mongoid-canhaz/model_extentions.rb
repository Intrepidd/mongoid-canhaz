require 'mongoid-canhaz/permission'
require 'mongoid-canhaz/object_extensions'
require 'mongoid-canhaz/subject_extensions'

module Canhaz
  module Mongoid

    module ModelExtensions

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      def canhaz_object?
        false
      end

      def canhaz_subject?
        false
      end

      module ClassMethods

        ##
        # Marks the current model as a canhaz object for authorizations
        #
        def acts_as_canhaz_subject
          include Canhaz::Mongoid::SubjectExtensions
          has_many :permissions, :class_name => 'Canhaz::Mongoid::Permission', :inverse_of => 'csubject'
        end

        ##
        # Marks the current model as a canhaz subject for authorizations
        #
        def acts_as_canhaz_object
          include Canhaz::Mongoid::ObjectExtensions
          class_eval do
            has_many :permissions_subjects, :class_name => 'Canhaz::Mongoid::Permission', :inverse_of => 'cobject'
          end
        end

      end

    end

  end
end
