require "bundler/gem_tasks"
require "rake"

task default: [:specs]

task :specs do 
	$LOAD_PATH.unshift 'lib', 'specs'
	Dir.glob('specs/*_spec*.rb').each { |file| require_relative file }
end