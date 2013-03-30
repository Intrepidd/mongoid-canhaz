module Canhaz
  module Mongoid
    module ObjectExtensions

      def canhaz_object?
        true
      end

      # Gets the subjects that have the corresponding permission and type on this model
      #
      # @param type [Class] The type of the subjects we're looking for
      # @param permission [String, Symbol] The permission
      def subjects_with_permission(type, permission)
        raise Exceptions::NotACanHazSubject unless type.respond_to?(:acts_as_canhaz_subject)
        permissions = self.permissions_subjects.where(:type => self.class.to_s, :permission => permission.to_s)
        type.in(:id => permissions.collect(&:csubject_id))
      end

    end
  end
end
