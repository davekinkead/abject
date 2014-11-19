# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'abject/version'

Gem::Specification.new do |spec|
  spec.name          = "abject"
  spec.version       = Abject::VERSION
  spec.authors       = ["Dave Kinkead"]
  spec.email         = ["dave@kinkead.com.au"]
  spec.summary       = %q{Abject Oriented Programming for the Rubyist}
  spec.description   = %q{Abject provides a snappy DSL to make Abject-O a reality!}
  spec.homepage      = "https://github.com/davekinkead/abject"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "curb"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
