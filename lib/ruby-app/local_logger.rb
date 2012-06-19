# -*- encoding : utf-8 -*-
require 'logger'

class LocalLogger < Logger
  def initialize(*a)
    super
    self.formatter = lambda { |s, d, p, m| "#{d.strftime("%d.%m.%Y %H:%M:%S")} #{m}\n" }
  end
end
