# -*- encoding : utf-8 -*-

#require 'yaml'

local_root = File.dirname(__FILE__)

# app from gem
require File.join(local_root, 'boot')

# config from gem
require File.join(local_root, 'common_config')

# local logger from gem
require File.join(local_root, 'local_logger')

# load default config from gem
require File.join(local_root, 'default_config')

# gems from app
Bundler.require(:default, App.env.to_sym)

GC.start

# AS dependencies
require 'active_support/dependencies'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/object/blank'

# load application app
require File.join(App.root, %w{lib application})

unless defined?(Rake)
  App.logger.info "Loading #{App.name}[#{App.env}] ..."
end

# default config from app
require File.join(App.root, %w{config config})

# configs from app for env
begin
  require File.join(App.root, %W( config environments #{App.env}))
rescue LoadError
  raise "unknown env #{App.env}"  
end

# unshift lib app
# $:.unshift(File.join(App.root, 'lib'))

ActiveSupport::Dependencies::autoload_paths << File.join(App.root, 'lib')

# unshift dirs app
dirs = Dir[File.join(App.root, %w{app *})]
dirs.each do |a| 
  $:.unshift(a)
  ActiveSupport::Dependencies::autoload_paths << a
end

# load initializers app
Dir["#{App.root}/config/initializers/*.rb"].each{ |x| load(x) }

# load initializers from other gems
unless App.initializer_paths.empty?
  App.initializer_paths.flatten.each do |path|
    require File.expand_path(path)
  end
end
        
# first load models app
Dir["#{App.root}/app/models/*.rb"].each{ |x| require x }

# later controllers app
Dir["#{App.root}/app/controllers/*.rb"].each{ |x| require x }

# later all app from app
dirs.each do |dir|
  Dir["#{dir}/*.rb"].each{ |x| require x }
end
