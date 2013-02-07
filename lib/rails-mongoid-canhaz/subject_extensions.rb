require 'rails-mongoid-canhaz/exceptions'

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
          raise Exceptions::NotACanHazObject unless (object.nil? || (object.respond_to?('canhaz_object?') && object.canhaz_object?))
          object_type = object.nil? ? nil : object.class.to_s
          object_id = object.nil? ? nil : object.id
          perm = self.permissions.build(:permission => permission, :type => object_type, :cobject_id => object_id)
          if perm.valid?
            perm.save
            return true
          end
          perm.destroy
          false
        end

        # Checks if the subject has a given permission on a given object
        #
        # @param permission [String, Symbol] The identifier of the permission
        # @param object [ActiveRecord::Base, nil] The model we are testing the permission on
        #  Can be nil if it is a global permission that does not target an object
        # @return [Bool] True if the user has the given permission, false otherwise
        def can?(permission, object = nil)
          raise Exceptions::NotACanHazObject unless (object.nil? || (object.respond_to?('canhaz_object?') && object.canhaz_object?))
          object_type = object.nil? ? nil : object.class.to_s
          object_id = object.nil? ? nil : object.id.to_s
          self.permissions.select { |p| p.permission == permission.to_s && p.type == object_type && p.cobject_id == object_id}.any?
        end

        # Checks if the subject does not have a given permission on a given object
        # Acts as a proxy of !subject.can?(permission, object)
        #
        # @param permission [String, Symbol] The identifier of the permission
        # @param object [ActiveRecord::Base] The model we are testing the permission on. Can be nil if it is a global permission that does not target an object
        # @return [Bool] True if the user has not the given permission, false otherwise
        def cannot?(permission, object = nil)
          !self.can?(permission, object)
        end

      end
    end
  end
end
