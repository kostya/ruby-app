$KCODE='u' if RUBY_VERSION < '1.9'

local_root = File.dirname(__FILE__)

# app from gem
require File.join(local_root, 'application')

$:.unshift(File.join(App.root, %w{ lib }))
