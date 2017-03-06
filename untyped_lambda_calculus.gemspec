# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'untyped_lambda_calculus/version'

Gem::Specification.new do |spec|
  spec.name          = 'untyped_lambda_calculus'
  spec.version       = UntypedLambdaCalculus::VERSION
  spec.authors       = ['Vasily Kolesnikov']
  spec.email         = ['re.vkolesnikov@gmail.com']

  spec.summary       = 'Simple untyped lambda calculus examples'
  spec.homepage      = 'https://github.com/v-kolesnikov/untyped_lambda_calculus'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
