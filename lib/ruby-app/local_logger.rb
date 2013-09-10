# -*- encoding : utf-8 -*-
require 'logger'

class LocalLogger < Logger
  FORMAT = '%d.%m.%Y %H:%M:%S'

  def initialize(*a)
    super

    self.formatter = Proc.new do |s, d, p, m|
      "#{d.strftime(FORMAT)} #{s.ljust(5)} -- #{m}\n"
    end
  end
end
