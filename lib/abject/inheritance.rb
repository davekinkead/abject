require 'yaml'

module Abject
	module Inheritance

		def self.included base
			base.extend ClassMethods
		end

		module ClassMethods
			
			def inherits(name, parent, &block)	
				define_method name do |*args| 
					base = method(parent[:from]).to_proc
					inheritied_method = "#{parse_method base.source_location}\n#{parse_method block.source_location}"
					p inheritied_method
					eval inheritied_method
				end
			end

		end

		private

		# save time copy & pasting old methods by doing it at run time!
		# TODO: count block keywords for loops and conditionals
		def parse_method(location)
			File.readlines(location[0])[location[1]..-1].join.split("end\n").first
		end


	end
end