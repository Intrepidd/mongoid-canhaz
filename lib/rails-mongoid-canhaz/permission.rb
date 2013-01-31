module Rails
  module Mongoid
    module Canhaz

      class Permission
        include ::Mongoid::Document

        field :type, :type => String
        field :cobject_id, :type => Integer
        field :permission, :type => String

      end

    end
  end
end
