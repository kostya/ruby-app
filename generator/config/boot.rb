require 'rubygems'

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require 'bundler/setup'

class Application
  class << self
    def root
      @root ||= File.join(File.dirname(__FILE__), %w(..))
    end
  end
end

require 'ruby-app/boot'
