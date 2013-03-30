require "mongoid-canhaz/version"
require "mongoid-canhaz/model_extentions"

module Canhaz
  module Mongoid
    module Document

      def self.included(base)
        base.send(:include, Canhaz::Mongoid::ModelExtensions)
      end

    end
  end
end
