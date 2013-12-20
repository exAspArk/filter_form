lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filter_form/version'

Gem::Specification.new do |spec|
  spec.name          = 'filter_form'
  spec.version       = FilterForm::VERSION
  spec.authors       = ['Evgeny Li']
  spec.email         = ['exaspark@gmail.com']
  spec.description   = %q{Build filter forms easily}
  spec.summary       = %q{Build your filter forms automatically}
  spec.homepage      = 'https://github.com/exAspArk/filter_form'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'simple_form'
  spec.add_dependency 'ransack'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'select2-rails'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
