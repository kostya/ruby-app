
# load gem rakes

Dir["#{File.dirname(__FILE__)}/tasks/*.{rb,rake}"].each do |f|
  load f
end


# load app rakes
if defined?(App)
  Dir["#{App.root}/lib/rake_tasks/*.{rb,rake}"].each do |f|
    load f
  end    
end