# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'XYGui/version'

Gem::Specification.new do |spec|
  spec.name          = "XYGui"
  spec.version       = XYGui::VERSION
  spec.authors       = ["sxysxy"]
  spec.email         = ["1441157749@qq.com"]

  spec.summary       = %q{A set of gui tools}
  spec.description   = %q{Based on Win32API}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  
  #spec.full_gem_path = Dir.pwd
  #spec.extensions = ["ext/extconf.rb"]
  spec.required_ruby_version = '>= 2.0.0'

end
