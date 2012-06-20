# -*- encoding : utf-8 -*-

class Application
  class << self
    def tmp_dir
      @tmp_dir ||= File.join(root, %w{tmp})
    end
    
    def logger_dir
      @logger_dir ||= File.join(root, %w{log})
    end

    def env
      @env ||= ENV['APP_ENV'] || ENV['RAILS_ENV'] || 'development'
    end

    def logger
      @logger ||= begin
        file = (env == 'test') ? File.open(File.join(logger_dir, 'ruby-app.log'), "a") : STDERR
        LocalLogger.new(file).tap do |l|
          l.level = App.config.log_level
        end
      end
    end

    def config
      CommonConfig
    end
  end
end

A = App = Application unless defined?(App)
