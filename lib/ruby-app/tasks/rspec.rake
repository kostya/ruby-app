begin
  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ['--options', "./spec/spec.opts"]
    # t.pattern = "./spec/**/*_spec.rb"
  end
  task :default => :spec

rescue LoadError
  puts "Warning, cant load rspec"
end
