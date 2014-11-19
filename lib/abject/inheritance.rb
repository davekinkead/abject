module Abject

	# Inheritance is a way to retain features of old code in newer code. The programmer derives 
	# from an existing function or block of code by making a copy of the code, then making 
	# changes to the copy. The derived code is often specialized by adding features not 
	# implemented in the original. In this way the old code is retained but the new code inherits 
	# from it.

	# Unlike Object Oriented programming, inheritance in Abject-O need not be limited to classes 
	# - functions and blocks may also inherit from other code.  Programs that use inheritance are 
	# characterized by similar blocks of code with small differences appearing throughout the source.
	# Another sign of inheritance is static members: variables and code that are not directly 
	# referenced or used, but serve to maintain a link to the original base or parent code. 
	module Inheritance

		# Improve performance and save memory by getting rid of those pesky local variables!
		# Method chaining #FTW! 
		# Such eval. So performant. Much wow!
		def inherits(parent, *args, &block)
			eval("Proc.new { |#{args.first.keys.map { |k| k.to_s }.join ','}| #{parse_method method(parent).to_proc.source_location}\n#{parse_method block.source_location} }").call args
		end

		private

		# Save time copy & pasting old methods by doing it at run time!
		# TODO: count block keywords for loops and conditionals
		def parse_method(location)
			File.readlines(location[0])[location[1]..-1].join.split("end\n").first
		end

	end
end