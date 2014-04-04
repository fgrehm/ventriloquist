source 'https://rubygems.org'

group :plugins do
  # Specify your gem's dependencies in ventriloquist.gemspec
  gemspec
  gem 'vagrant-lxc',      github: 'fgrehm/vagrant-lxc'
  gem 'vagrant-pristine', github: 'fgrehm/vagrant-pristine'
  gem 'vagrant-cachier',  github: 'fgrehm/vagrant-cachier'
end

group :development do
  gem 'guard-rspec'
end

group :development, :test do
  gem 'rake'
  gem 'vagrant', github: 'mitchellh/vagrant', tag: 'v1.5.2'
  gem 'rspec', '3.0.0.beta2'
  gem 'simplecov', require: false
end
