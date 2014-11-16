require File.expand_path('../lib/git-sleep', __FILE__)

Gem::Specification.new do |git_sleep|
  git_sleep.name = 'git-sleep'
  git_sleep.version = GitSleep::VERSION
  git_sleep.summary = 'Uses Jawbone to figure out if you are awake enough' \
    'to code based on your sleep data'
  git_sleep.description   = 'Uses Jawbone to figure out if you are awake ' \
    'enough to code'
  git_sleep.authors       = ['Max Jacobson', 'Ruthie Nachmany', 'Sarah Duve']
  git_sleep.email         = [
    'max@hardscrabble.net',
    'ruthie.nachmany@flatironschool.com',
    'saduve@gmail.com'
  ]
  git_sleep.files         = Dir[
    './*.{md,gemspec}',
    './.gitignore',
    './hooks/*',
    './bin/*',
    './lib/*'
  ]
  git_sleep.require_paths = ['lib']
  git_sleep.executables   = ['git-sleep']
  git_sleep.homepage      = GitSleep::OUR_SITE
  git_sleep.license       = 'MIT'
  git_sleep.required_ruby_version = '>= 2.0.0'
  git_sleep.add_runtime_dependency 'httparty', '~> 0.13'
  git_sleep.add_runtime_dependency 'netrc', '~> 0.8'
  git_sleep.add_development_dependency 'rubocop', '~> 0.27'
  git_sleep.add_development_dependency 'rspec', '~> 3.1'
  git_sleep.add_development_dependency 'pry', '~> 0.10'
end

