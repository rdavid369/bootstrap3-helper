$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bootstrap3_helper/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bootstrap3_helper'
  s.version     = Bootstrap3Helper::VERSION
  s.authors     = ['Robert David']
  s.email       = ['rdavid369@gmail.com']
  s.homepage    = 'https://github.com/rdavid369/bootstrap3-helper/blob/master/lib/bootstrap3_helper.rb'
  s.summary     = 'Simple gem for rapidly building bootstrap 3 components'
  s.description = 'Simple gem for rapidly building bootstrap 3 components'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.6'

  s.add_development_dependency 'bootstrap-sass', '~> 3.4.1'
  s.add_development_dependency 'jquery-rails', '~> 4.3'
  s.add_development_dependency 'sassc-rails', '>= 2.1.0'
  s.add_development_dependency 'sqlite3', '~> 1.3.6'
end
