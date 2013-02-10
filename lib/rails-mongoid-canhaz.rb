require "rails-mongoid-canhaz/version"
require "rails-mongoid-canhaz/model_extentions"

module Rails
  module Mongoid
    module Canhaz
      module Document

        def self.included(base)
          base.send(:include, Rails::Mongoid::Canhaz::ModelExtensions)
        end

      end
    end
  end
end
