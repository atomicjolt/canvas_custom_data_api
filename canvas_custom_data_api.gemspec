$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "canvas_custom_data_api"
  spec.version       = "0.1"
  spec.authors       = ["Matt Petro"]
  spec.email         = ["matt.petro@atomicjolt.com"]
  spec.homepage      = "http://www.atomicjolt.com"
  spec.summary       = %q{Bulk fetch API for user custom data}

  spec.files = Dir["{app,config,db,lib}/**/*"]
  spec.test_files = Dir["spec_canvas/**/*"]

  spec.add_dependency "rails", ">= 3.2"
end
