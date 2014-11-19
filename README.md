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
				fullname = "#{results[:first_name]} #{results[:last_name]}"
			end


			def find_email(id)
				results = DB.query :customer, id
				fullname = "#{results[:first_name]} #{results[:last_name]}"
				email = "#{results[:email]}"
			end

		end


The function `find_email` was inherited from `find_name` when email addresses were added to the application. Inheriting code in this way leverages working code with less risk of introducing bugs.  Abject provides a helpful DSL for functional and block inheritance.


		class Customer
			include Abject::Inheritance

			def find_name(id)
				results = DB.query :customer, id
				fullname = "#{results[:first_name]} #{results[:last_name]}"
			end			

			def find_email(id)
				inherits :find_name, id: id do 
					email = "#{results[:email]}"
				end
			end

		end



## Contributing

1. Fork it ( https://github.com/[my-github-username]/abject/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
