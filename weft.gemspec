$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'weft/version'

Gem::Specification.new do |s|
  s.name     = 'weft'
  s.version  = ::Weft::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron/weft'
  s.description = s.summary = 'Easily provide block-scoped context values in your Ruby code.'
  s.platform = Gem::Platform::RUBY

  s.require_path = 'lib'

  s.files = Dir['{lib,test}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'weft.gemspec']
end
