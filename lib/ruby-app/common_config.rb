# -*- encoding : utf-8 -*-

class CommonConfig
  @@configs = {}
  
  def self.define(name, &block)
    s = Scope.new
    s.instance_eval(&block)
    @@configs.merge!(s.configs)
  end
  
  class Scope
    def initialize
      @configs = {}
    end
    
    attr_reader :configs
   
  private
  
    def method_missing(name, *params, &block)
      if name.to_s =~ /_address$/i
        require 'ostruct'
        @configs[name] = block || OpenStruct.new(:host => params[0], :port => params[1].to_i)
      else
        params = params[0] if params.size == 1
        @configs[name] = block || params
      end
    end
  end

  def self.[]=(option, value)
    @@configs[option.to_sym] = value
  end

  def self.[](option)
    if @@configs.key?(option)
      res = @@configs[option]
      res.is_a?(Proc) ? res.call : res
    else
      super
    end
  end

  def self.method_missing(*args)
    if @@configs.key?(args[0])
      res = @@configs[args[0]]
      res.is_a?(Proc) ? res.call : res
    else
      super
    end
  end
end
