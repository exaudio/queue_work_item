# coding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "qwi"
  spec.version       = '1.0'
  spec.authors       = ["Jon Hanson"]
  spec.email         = ["jon.hanson@verizon.com"]
  spec.summary       = %q{Short summary of project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "https://www.google.com"
  spec.license       = "Free"

  spec.files         = ['lib/qwi.rb']
  spec.executables   = ['bin/qwi']
  spec.test_files    = ['tests/test_qwi.rb']
  spec.require_paths = ["lib"]
end