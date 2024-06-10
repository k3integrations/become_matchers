# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'become_matchers/version'

Gem::Specification.new do |s|
  s.name        = 'become_matchers'
  s.version     = BecomeMatchers::VERSION.dup
  s.authors     = ['K3 Integrations']
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.homepage    = 'https://github.com/k3integrations/become_matchers'
  s.summary     = 'Simple RSpec matchers that wait for an expected value'
  s.license     = 'Apache-2.0'

  s.files = Dir['lib/**/*', 'README.md', 'LICENSE', 'become_matchers.gemspec']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency('rspec', '>= 3.0.0')
end
