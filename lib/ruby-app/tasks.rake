
task :environment do
  require File.join(App.root, %w{ config environment })
end

# load gem rakes
Dir["#{File.dirname(__FILE__)}/tasks/**/*.{rb,rake}"].each do |f|
  load f
end

# load other gems rakes
if defined?(App) && !App.rake_paths.empty?
  App.rake_paths.each do |path|
    load File.expand_path(path)
  end
end

# load app rakes
if defined?(App)
  Dir["#{App.root}/lib/rake_tasks/**/*.{rb,rake}"].each do |f|
    load f
  end
end
