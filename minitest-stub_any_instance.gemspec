# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require lib + '/minitest/stub_any_instance/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-stub_any_instance"
  spec.version       = Minitest::StubAnyInstance::VERSION
  spec.authors       = ["Sammy Larbi", "Vasiliy Ermolovich"]
  spec.email         = ["sam@codeodor.com"]
  spec.description   = %q{Adds a method to MiniTest that stubs any instance of a class.}
  spec.summary       = %q{}
  spec.homepage      = "https://github.com/codeodor/minitest-stub_any_instance"
  spec.license       = "MIT"

  spec.files         = ["lib/minitest/stub_any_instance.rb"]
  spec.executables   = []
  spec.test_files    = ["test/stub_any_instance_test.rb"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version    = '>= 2.0'
  spec.add_development_dependency "bundler", ">= 1.11.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
