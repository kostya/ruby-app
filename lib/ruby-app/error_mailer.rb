# -*- encoding : utf-8 -*-

class ErrorMailer
end

module ErrorMailer::BlankSlate
  def message(msg, params = nil)
  end

  def exception(e, params = nil)
  end
end

module ErrorMailer::Logger
  def message(msg, params = nil)
    super
    App.logger.error { msg }
  end

  def exception(e, params = nil)
    super
    App.logger.error{ "#{e.class}: #{e.message}\n#{e.backtrace*"\n"}" }
  end
end

module ErrorMailer::ReraiseCtrlC
  def exception(e, params = nil)
    if SignalException === e || SystemExit === e
      raise e
    end
    super
  end
end

class ErrorMailer
  class << self
    include ErrorMailer::BlankSlate
    include ErrorMailer::Logger
    include ErrorMailer::ReraiseCtrlC

    def mail_message(m, params = nil)
      message(m)
    end

    def mail_exception(e, params = nil)
      exception(e, params)
    end

    def safe(params = nil, &block)
      yield

    rescue Object => ex
      self.mail_exception(ex, params)
    end
  end

end
