require 'rake'
require 'spec/rake/spectask'

# require './init.rb'

desc 'Default: run specs.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.ruby_opts = ['-rinit.rb']
  t.spec_files = FileList['spec/**/*_spec.rb']
end