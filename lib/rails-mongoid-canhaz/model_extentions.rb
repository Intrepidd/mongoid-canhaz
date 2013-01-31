require 'rails-mongoid-canhaz/permission'
require 'rails-mongoid-canhaz/object_extensions'
require 'rails-mongoid-canhaz/subject_extensions'

module Rails
  module Mongoid
    module Canhaz

      module ModelExtensions

        def self.included(base)
          base.class_eval do

            class << self
              alias_method :old_included, :included

              def included(base)
                old_included(base)
                base.send(:extend, ClassMethods)
              end
            end

          end
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
            include Rails::Mongoid::Canhaz::SubjectExtensions

            embeds_many :permissions, :class_name => 'Rails::Mongoid::Canhaz::Permission'

            class_name = self.class.to_s.singularize.to_sym

            Rails::Mongoid::Canhaz::Permission.class_eval do
              embedded_in class_name
            end

          end

          ##
          # Marks the current model as a canhaz subject for authorizations
          #
          def acts_as_canhaz_object
            include Rails::Mongoid::Canhaz::ObjectExtensions
          end

        end

      end

    end
  end
end
