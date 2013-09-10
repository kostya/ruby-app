# -*- encoding : utf-8 -*-

class ErrorMailer
end

module ErrorMailer::BlankSlate
  def message(msg)
  end

  def exception(e)
  end
end

module ErrorMailer::Logger
  def message(msg)
    super
    App.logger.error { msg }
  end

  def exception(e)
    super
    App.logger.error{ "#{e.class}: #{e.message}\n#{e.backtrace*"\n"}" }
  end
end

module ErrorMailer::ReraiseCtrlC
  def exception(e)
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

    def mail_message(m)
      message(m)
    end

    def mail_exception(e)
      exception(e)
    end

    def safe(&block)
      yield

    rescue => ex
      self.mail_exception(ex)
    end
  end

end
