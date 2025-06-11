$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'use_context/version'

Gem::Specification.new do |s|
  s.name     = 'use_context'
  s.version  = ::UseContext::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron/use_context'
  s.description = s.summary = 'Easily provide block-scoped context values in your Ruby code.'
  s.platform = Gem::Platform::RUBY

  s.require_path = 'lib'

  s.files = Dir['{lib,test}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'use_context.gemspec']
end
