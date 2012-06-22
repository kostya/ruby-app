require 'rubygems'

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require 'bundler/setup'

class Application
  class << self
    def root
      @root ||= File.expand_path('../..', __FILE__)
    end
  end
end

require 'ruby-app/boot'
