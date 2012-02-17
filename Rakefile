require 'rspec/core/rake_task'

desc "Default: run specs"
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['-c']
end
