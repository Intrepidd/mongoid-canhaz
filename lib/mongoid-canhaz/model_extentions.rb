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

          embeds_many :permissions, :class_name => 'Canhaz::Mongoid::Permission'

          class_name = self.class.to_s.singularize.to_sym

          Canhaz::Mongoid::Permission.class_eval do
            embedded_in class_name
          end

        end

        ##
        # Marks the current model as a canhaz subject for authorizations
        #
        def acts_as_canhaz_object
          include Canhaz::Mongoid::ObjectExtensions
        end

      end

    end

  end
end
