guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/ventriloquist/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')            { "spec" }
end
