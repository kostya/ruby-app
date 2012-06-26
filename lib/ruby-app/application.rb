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
      @env ||= begin
        env = ENV['APP_ENV'] || ENV['RAILS_ENV']
        
        # if not specify env, try find file with env config/environment.current
        # which created this file by a capistrano, by example
        unless env
          path = File.join(root, %w{ config environment.current })
          if File.exists?(path)
            env = File.read(path)
            env.chomp!
          end
        end       
        
        env = 'development' unless env
        
        env
      end
    end
    
    alias :environment :env

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
    
    def identifier
      "ruby-app"
    end
    
    def rake_paths
      @rake_paths ||= []
    end
    
    def initializer_paths
      @initializer_paths ||= []
    end
    
    def bundler_group
    end
    
  end
end

App = Application unless defined?(App)
