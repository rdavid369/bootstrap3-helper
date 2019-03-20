$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bootstrap3_helper/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bootstrap3_helper'
  s.version     = Bootstrap3Helper::VERSION
  s.authors     = ['Robert David']
  s.email       = ['rdavid369@gmail.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Bootstrap3Helper.'
  s.description = 'TODO: Description of Bootstrap3Helper.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.6'

  s.add_development_dependency 'sqlite3'
end
