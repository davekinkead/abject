require 'abject/reader'

module Abject

  # The idea behind encapsulation is to keep the data separate from the code. This is sometimes 
  # called data hiding, but the data is not really hidden, just protected inside another layer 
  # of code. For example, it’s not a good practice to scatter database lookups all over the place. 
  # An abject practice is to wrap or hide the database in functions or subroutines, thereby 
  # encapsulating the database. In the `find_name` function above the database is not queried 
  # directly — a function is called to read the database record. All `find_name` and `find_email` 
  # (and the many other functions like them) “know” is where in the customer record to find 
  # the bits of data they need. How the customer record is read is encapsulated in some other module.

  # Encapsulation can also be achieved through the use of protected functions.  The importance 
  # of function safety cannot be stressed enough.  Unprotected methods result in data spillage, 
  # tight object coupling, and other morally questionable behaviours. Abject-O achieves this 
  # with the `#` character and many IDE's also provide macros to protect large sections of 
  # your code base efficiently - `opt arrow` on Sublime Text for example. 
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
