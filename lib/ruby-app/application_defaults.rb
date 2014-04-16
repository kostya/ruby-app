# -*- encoding : utf-8 -*-

$app_started_at = Time.now

module Application::Defaults

  def tmp_dir
    @gem_tmp_dir ||= File.join(root, %w{tmp})
  end

  def logger_dir
    @gem_logger_dir ||= File.join(root, %w{log})
  end

  def env
    @gem_env ||= begin
      env = ENV['APP_ENV'] || ENV['RAILS_ENV']

      # if not specify env, try find file with env config/environment.current
      # which created this file by a capistrano, by example
      unless env
        path = File.join(root, %w{ config environment.current })
        if File.exists?(path)
          env = File.read(path)
          env.strip!
        end
      end

      env = 'development' unless env

      env
    end
  end

  alias :environment :env

  def logger
    @gem_logger ||= begin
      file = env.to_s['test'] ? File.open(File.join(logger_dir, "#{name rescue 'ruby-app'}.log"), "a") : STDERR
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
    @gem_rake_paths ||= []
  end

  def initializer_paths
    @gem_initializer_paths ||= []
  end

  def bundler_group
  end

  def started_at
    $app_started_at
  end

  def error_mailer
    ErrorMailer
  end

  def revision
    @_revision ||= File.read(File.join(root, %w[REVISION]))[0..5] rescue nil
  end

  def hostname
    @_hostname ||= `hostname`.chop
  end
end

Application.extend(Application::Defaults)

App = Application unless defined?(App)
