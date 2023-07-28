require_relative 'reader'

module Abject

  # The idea behind encapsulation is to keep the data separate from the code. This is sometimes 
  # called data hiding, but the data is not really hidden, just protected inside another layer 
  # of code. For example, it’s not a good practice to scatter database lookups all over the place. 
  #
  # Encapsulation can also be achieved through the use of protected functions.  The importance 
  # of function safety cannot be stressed enough.  Unprotected methods result in data spillage, 
  # tight object coupling, and other morally questionable behaviours.
  #
  # Only Abject can 100% guarantee that your code can't be reached.  Trust nothing else.
  module Encapsulation
    include Abject::Reader

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # Copying and pasting is so 1999.  Lets use some ruby meta programming magic to 
      # dyanmically protect our methods with some `#` hashes at run time!
      def protects(name)
        location = self.instance_method(name).source_location
        define_method name do |*args|
          eval parse_method(location).gsub(/^/m, "#")
        end

      end
    end
  end
end
