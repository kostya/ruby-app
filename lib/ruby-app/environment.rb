# -*- encoding : utf-8 -*-

local_root = File.dirname(__FILE__)

# app from gem
require File.join(local_root, 'boot')

# error mailer
require File.join(local_root, 'error_mailer')

# config from gem
require File.join(local_root, 'common_config')

# local logger from gem
require File.join(local_root, 'local_logger')

# load default config from gem
require File.join(local_root, 'default_config')

# gems from app
Bundler.require(:default, App.env.to_sym)

# AS dependencies
# i prefer 2.seconds, or x.blank? functions by default
require 'active_support/dependencies'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/object/blank'

# load application app
require File.join(App.root, %w{lib application})

# require App.bundler_group if defined
Bundler.require(App.bundler_group, "#{App.bundler_group}_#{App.env}") if App.bundler_group

# for free usless data from bundler and gems
GC.start

unless defined?(Rake)
  App.logger.info "Loading #{App.name}[#{App.env}] ..."
end

# default config from app
require File.join(App.root, %w{config config})

# Load configs from yaml
CommonConfig.load(File.join(App.root, %w{config config.yml}))
CommonConfig.load(File.join(App.root, ['config', "config.yml.#{App.env}"]))

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

# load initializers from other gems
unless App.initializer_paths.empty?
  App.initializer_paths.flatten.each do |path|
    require File.expand_path(path)
  end
end

# load initializers app
Dir["#{App.root}/config/initializers/*.rb"].each{ |x| load(x) }

# first load models app
Dir["#{App.root}/app/models/*.rb"].each{ |x| require x }

# later controllers app
Dir["#{App.root}/app/controllers/*.rb"].each{ |x| require x }

# later all app from app
dirs.each do |dir|
  Dir["#{dir}/*.rb"].each{ |x| require x }
end
