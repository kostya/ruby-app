# -*- encoding : utf-8 -*-
require 'rubygems'

ENV['APP_ENV'] = 'test3'

class Application
  def self.root
    File.join(File.dirname(__FILE__), %w(..))
  end
end

$:.unshift(File.join(File.dirname(__FILE__), %w{.. .. .. lib}))
require 'ruby-app/environment'

App.config.test_thing << 3
Application.config.apps << App.env

require '4'
