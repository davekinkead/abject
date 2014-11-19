# Abject

### Because you're been doing all it wrong!

Abject Orientated Programming (Abject-O) is a set of best practices developed by [Greg Jorgensen](http://typicalprogrammer.com/abject-oriented/) that promotes code reuse and ensures programmers are producing code that can be used in production for a long time.

For too long, the beauty of ruby has been sullied by the misguided follies of Gamma & his cronies.  Abject rectifies this by finally bringing Abject-O to ruby.


## Installation

Add this line to your application's Gemfile:


		gem 'abject'


And then execute:


    $ bundle


Or install it yourself as:


    $ gem install abject


## Usage

### Inheritance

Inheritance is a way to retain features of old code in newer code. The programmer derives from an existing function or block of code by making a copy of the code, then making changes to the copy. The derived code is often specialized by adding features not implemented in the original. In this way the old code is retained but the new code inherits from it.

Unlike Object Oriented programming, inheritance in Abject-O need not be limited to classes - functions and blocks may also inherit from other code.  Programs that use inheritance are characterized by similar blocks of code with small differences appearing throughout the source. Another sign of inheritance is static members: variables and code that are not directly referenced or used, but serve to maintain a link to the original base or parent code. 


		class Customer

			def find_name(id)
				results = DB.query :customer, id
				fullname = "#{results[1]} #{results[2]}"
			end


			def find_email(id)
				results = DB.query :customer, id
				fullname = "#{results[1]} #{results[2]}"
			
				# email addresses can now be found in the 
				# `fax-home` column 
				email = "#{results[5]}"
			end

		end


The function `find_email` was inherited from `find_name` when email addresses were added to the application. Inheriting code in this way leverages working code with less risk of introducing bugs.  But this is Ruby - implicit is better than explicit - so Abject provides a helpful DSL for functional and block inheritance that dynamically copies and pastes the inherited code at run time. [View source](lib/abject/inheritance.rb).


		class Customer
			include Abject::Inheritance

			def find_name(id)
				results = DB.query :customer, id
				fullname = "#{results[1]} #{results[2]}"
			end			

			def find_email(id)
				inherits :find_name, id: id do 
					email = "#{results[5]}"
				end
			end

		end


### Polymorphism

Code is polymorphic when it gives different outputs for different kinds of inputs.  To quote wikipedia:

> a function that denotes different and potentially heterogeneous implementations depending on a limited range of individually specified types and combinations

When learning Abject-O techniques, programmers frequently get caught up by this idea. It sounds hard but polymorphism is simple and easy to implement.  As an example, the functions above can be rewritten as a single polymorphic function by inheriting the code that already works and then encapsulating it into a new function:


		class Customer

			def find_customer(what, id)
				if what == 'name'
					results = DB.query :customer, id
					fullname = "#{results[1]} #{results[2]}"
				elsif what == 'email'
					results = DB.query :customer, id
					fullname = "#{results[1]} #{results[2]}"
				
				# email addresses can now be found in the 
				# `fax-home` column 
				email = "#{results[5]}"				
			end

		end


### Encapsulation

The idea behind encapsulation is to keep the data separate from the code. This is sometimes called data hiding, but the data is not really hidden, just protected inside another layer of code. For example, it’s not a good practice to scatter database lookups all over the place. An Abject-O practice is to wrap or hide the database in a function, thereby encapsulating the database. In the `find_name` function above the database is not queried directly — a function is called to read the database record. All `find_name` and `find_email` (and the many other functions like them) “know” is where in the customer record to find the bits of data they need. How the customer record is read is encapsulated in some other module.

Encapsulation can also be achieved through the use of protected functions.  The importance of function safety cannot be stressed enough as unprotected methods may result in data spillage, tight object coupling, and other morally questionable behaviours. In Ruby, functions can be protected with the `#` character and many IDE's also provide macros to protect large sections of your code base efficiently - `opt arrow` on Sublime Text for example.  


		# An exposed public method
		def exposed_method(customer, id)
			query = DB.find :customer, id
			customer = Customer.new query
		end

		#  A protected method
		# def protected_method(customer, id)
		#	 query = DB.find :customer, id
		#	 customer = Customer.new query
		# end


The Abject gem provides an elegant means of protecting methods from any unwanted spillage and leakage that might result from tight coupling.  Simply declare a function protected at the end of a class and let Ruby's metaprogramming magic do its work. [View source](lib/abject/encapsulation.rb).


		class Foo
			include Abject::Encapsulation

			def bar
				"bar"
			end

			def baz
				"baz"
			end

			protects :baz

		end

		p Foo.new.bar # => "bar"
		p Foo.new.baz # => nil



---

## Contributing

1. Fork it ( https://github.com/[my-github-username]/abject/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
