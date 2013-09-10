require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  ENV['COVERAGE'] = 'true'
  t.pattern = "./spec/**/*_spec.rb"
end

desc 'Default task which runs all specs with code coverage enabled'
task :default => ['spec']
