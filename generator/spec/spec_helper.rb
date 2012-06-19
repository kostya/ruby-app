require 'rubygems'
require "bundler/setup"

ENV['APP_ENV'] = 'test'

require File.join(File.dirname(__FILE__), %w{.. config environment})
