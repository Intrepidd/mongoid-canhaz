module Rails
  module Mongoid
    module Canhaz

      module SubjectExtensions

        def canhaz_subject?
          true
        end

        # Creates a permission on a given object
        #
        # @param permission [String, Symbol] The identifier of the permission
        # @param object [ActiveRecord::Base, nil] The model on which the permission is effective
        #   Can be nil if it is a global permission that does not target an object
        # @return [Bool] True if the role was successfully created, false if it was already present
        def can!(permission, object = nil)
          object_type = object.nil? ? nil : object.class.to_s
          object_id = object.nil? ? nil : object.id
          self.permissions.push Permission.new(:permission => permission, :type => object_type, :cobject_id => object_id)
        end

      end

    end
  end
end
