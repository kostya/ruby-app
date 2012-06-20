# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), %w{ boot })

ENV['APP_ENV'] = 'test3'

$:.unshift(File.join(File.dirname(__FILE__), %w{.. .. .. lib}))
require 'ruby-app/environment'

App.config.test_thing << 3
Application.config.apps << App.env

require '4'
