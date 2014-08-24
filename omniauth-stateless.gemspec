$:.push File.expand_path('../lib', __FILE__)

require 'rails'
require 'omniauth'
require 'omniauth-stateless'

# Maintain your gem's version:
require 'omniauth/stateless/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
    s.name        = 'omniauth-stateless'
    s.version     = OmniAuth::Stateless::VERSION
    s.authors     = ['Ken Fehling']
    s.email       = ['ken@androidideas.org']
    s.homepage    = 'http://androidideas.org'
    s.summary     = 'Helps OmniAuth to be used statelessly (e.g. with REST APIs)'
    s.description = 'Authenticates during each request instead of using sessions'
    s.license     = 'MIT'

    s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
    s.test_files = Dir['test/**/*']

    s.add_dependency 'rails'
    s.add_dependency 'addressable'
    s.add_dependency 'omniauth'

    #s.add_development_dependency 'sqlite3'
end