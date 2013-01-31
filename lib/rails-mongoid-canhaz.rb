require "rails-mongoid-canhaz/version"
require "rails-mongoid-canhaz/model_extentions"

if defined? Mongoid::Document
  Mongoid::Document.send(:include, Rails::Mongoid::Canhaz::ModelExtensions)
end
