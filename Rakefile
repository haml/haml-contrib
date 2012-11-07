require "rake/testtask"
require "rake/clean"
require "yard"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'lib' << 'test'
  t.test_files = Dir["test/**/*_test.rb"]
  t.verbose = true
end

CLEAN.replace %w(doc .yardoc)

YARD::Rake::YardocTask.new
