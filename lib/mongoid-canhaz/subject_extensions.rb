require 'mongoid-canhaz/exceptions'

module Canhaz
  module Mongoid

    module SubjectExtensions

      def canhaz_subject?
        true
      end

      # Creates a permission on a given object
      #
      # @param permission [String, Symbol] The identifier of the permission
      # @param object [Object, nil] The model on which the permission is effective
      #   Can be nil if it is a global permission that does not target an object
      # @return [Bool] True if the role was successfully created, false if it was already present
      def can!(permission, object = nil)
        assert_permission_not_nil(permission)
        assert_canhaz_object(object)
        object_type = object.nil? ? nil : object.class.to_s
        object_id = object.nil? ? nil : object.id
        perm = self.permissions.build(:permission => permission, :type => object_type, :cobject_id => object_id)
        if perm.valid?
          perm.save
          return true
        end
        self.permissions.delete perm
        perm.destroy
        false
      end

      # Checks if the subject has a given permission on a given object
      #
      # @param permission [String, Symbol] The identifier of the permission
      # @param object [Object, nil] The model we are testing the permission on
      #  Can be nil if it is a global permission that does not target an object
      # @return [Bool] True if the user has the given permission, false otherwise
      def can?(permission, object = nil)
        assert_canhaz_object(object)
        assert_permission_not_nil(permission)
        find_canhaz_permission(object, permission).present?
      end

      # Checks if the subject does not have a given permission on a given object
      # Acts as a proxy of !subject.can?(permission, object)
      #
      # @param permission [String, Symbol] The identifier of the permission
      # @param object [Object] The model we are testing the permission on. Can be nil if it is a global permission that does not target an object
      # @return [Bool] True if the user has not the given permission, false otherwise
      def cannot?(permission, object = nil)
        !self.can?(permission, object)
      end

      # Removes a permission on a given object
      #
      # @param permission [String, Symbol] The identifier of the permission
      # @param object [Object, nil] The model on which the permission is effective. Can be nil if it is a global permission that does not target an object
      # @return [Bool] True if the role was successfully removed, false if it did not exist
      def cannot!(permission, object = nil)
        assert_canhaz_object(object)
        assert_permission_not_nil(permission)
        row = find_canhaz_permission(object, permission)
        return false unless row.present?
        self.permissions.delete row
        row.destroy and return true
      end

      # Gets All objects that match a given type and permission
      #
      # @param type [Class] The type of the objects
      # @param permission [String, Symbol] The name of the permission
      # @return The macthing objects in an array
      def objects_with_permission(type, permission)
        raise Exceptions::NotACanHazObject unless type.respond_to?(:acts_as_canhaz_object)
        permissions = self.permissions.where(:permission => permission.to_s, :type => type.to_s)
        type.in(:id => permissions.collect(&:cobject_id))
      end

      private

      def assert_canhaz_object(object)
        raise Exceptions::NotACanHazObject unless (object.nil? || (object.respond_to?('canhaz_object?') && object.canhaz_object?))
      end

      def assert_permission_not_nil(permission)
        raise Exceptions::NullPermission unless permission.present?
      end

      def find_canhaz_permission(object, permission)
        object_type = object.nil? ? nil : object.class.to_s
        object_id = object.nil? ? nil : object.id.to_s
        self.permissions.where(:permission => permission.to_s, :type => object_type, :cobject_id => object_id).to_a.first
      end

    end
  end
end
