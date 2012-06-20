require 'rubygems'

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require 'bundler/setup'

class Application
  def self.root
    File.join(File.dirname(__FILE__), %w(..))
  end
end

require 'ruby-app/boot'
