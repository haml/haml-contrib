Gem::Specification.new do |spec|
  spec.name        = 'haml-contrib'
  spec.summary     = "Addons to Haml"
  spec.version     = File.read(File.dirname(__FILE__) + '/VERSION').strip
  spec.authors     = ['Norman Clarke']
  spec.email       = ['norman@njclarke.com']
  spec.files       = Dir['lib/**/*', 'test/**/*', '*.md']
  spec.test_files  = Dir["test/**/*"]
  spec.homepage    = 'http://haml.info/'
  spec.has_rdoc    = false
  spec.description = "Addons for the Ruby implementation of the Haml template language."

  spec.add_dependency "haml", ">= 3.2.0.alpha.13"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "nokogiri"

end
