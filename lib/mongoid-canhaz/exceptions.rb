module Canhaz
  module Mongoid
    module Exceptions
      class NotACanHazSubject < StandardError; end
      class NotACanHazObject < StandardError; end
      class NullPermission < StandardError ; end
    end
  end
end
