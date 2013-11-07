source 'https://rubygems.org'

# Specify your gem's dependencies in ventriloquist.gemspec
gemspec

group :development, :test do
  gem 'rake'
  gem 'vagrant', github: 'mitchellh/vagrant'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'bogus'
end

group :development do
  gem 'vagrant-lxc',           github: 'fgrehm/vagrant-lxc'
  gem 'vagrant-pristine',      github: 'fgrehm/vagrant-pristine'
  gem 'vagrant-global-status', github: 'fgrehm/vagrant-global-status'
  gem 'vagrant-cachier',       github: 'fgrehm/vagrant-cachier'
  gem 'vocker',                github: 'fgrehm/vocker'
  gem 'guard-rspec'
end
