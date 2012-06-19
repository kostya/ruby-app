# -*- encoding : utf-8 -*-
require 'rubygems'
require 'bundler/setup'

# ENV['APP_ENV'] = 'production' # uncomment if want forced env

class Application
  def self.root
    File.join(File.dirname(__FILE__), %w(..))
  end
end

require 'ruby-app/environment'
