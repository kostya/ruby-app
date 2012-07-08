$KCODE='u' if RUBY_VERSION < '1.9'

local_root = File.dirname(__FILE__)

# define class if undefined
class Application
end

# app from gem
require File.join(local_root, 'application_defaults')

$:.unshift(File.join(App.root, %w{ lib }))
