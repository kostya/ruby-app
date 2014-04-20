# -*- encoding : utf-8 -*-

begin
  require 'hoptoad_notifier'

  class ErrorMailer
  end

  HoptoadNotifier.configure do |config|
    config.api_key = App.config.hoptoad_key
  end

  module ErrorMailer::Hoptoad
    def defer
      Thread.new{ yield }
    rescue Object => ex
      App.logger.error { "defer error '#{ex.message}', #{ex.backtrace.inspect}" }
    end

    def app_params(params = nil)
      par = {:app_name => App.name, :rev => App.revision}
      par.merge!(params) if params.is_a?(Hash)
      { :parameters => par, :project_root => App.root }
    end

    def message(msg, params = nil)
      super

      defer do
        HoptoadNotifier.notify(app_params(params).merge(:error_message => msg))
      end
    end

    def exception(e, params = nil)
      super

      defer do
        HoptoadNotifier.notify(e, app_params(params))
      end
    end
  end

  class ErrorMailer
    class << self
      include ErrorMailer::Hoptoad
    end
  end

rescue LoadError
  App.logger.error { "Not found gem hoptoad_hotifier, add it to Gemfile" }
end
