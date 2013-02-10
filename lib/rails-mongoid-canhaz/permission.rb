module Rails
  module Mongoid
    module Canhaz

      class Permission
        include ::Mongoid::Document

        field :type, :type => String
        field :cobject_id, :type => String
        field :permission, :type => String

        validates :permission, :presence => true, :uniqueness => {:scope => [:type, :cobject_id]}
      end

    end
  end
end
