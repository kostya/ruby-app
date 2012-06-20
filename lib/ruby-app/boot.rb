$KCODE='u' if RUBY_VERSION < '1.9'

# app from gem
require File.join(File.dirname(__FILE__), 'application')

$:.unshift(File.join(App.root, %w{ lib }))
