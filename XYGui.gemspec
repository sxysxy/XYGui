# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'XYGui/version'

traverse_dir = ->(file_path, files = []) do
  if File.directory?(file_path)
    Dir.foreach(file_path) do |file|
      if file !="." and file !=".."
        traverse_dir.call(file_path+"/"+file, files)
      end
    end
  else
    files.push(file_path)
  end
  return files
end

traverse_dirs = ->(*file_paths) do
  files = Array.new
  file_paths.flatten.each do |file_path|
    traverse_dir.call(file_path, files)
  end
  return files
end

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

  spec.files         = traverse_dirs.call("lib", "example", "ext")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  
  #spec.full_gem_path = Dir.pwd
  #spec.extensions = ["ext/extconf.rb"]
  spec.required_ruby_version = '>= 2.0.0'

end
