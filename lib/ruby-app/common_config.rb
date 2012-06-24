# -*- encoding : utf-8 -*-

class CommonConfig
  @@configs = {}
  
  def self.define(name, &block)
    s = Scope.new
    s.instance_eval(&block)
    @@configs.merge!(s.configs)
  end

  def self.load(config_file, shouldbe = false)
    if File.exists?(config_file)
      require 'yaml'
      
      h = YAML.load_file(config_file)
      if h.is_a?(Hash)
        h.symbolize_keys!
        @@configs.merge!(h)
      else
        raise "config should be a Hash, but not #{h.inspect}"
      end
    else
      if shouldbe
        raise "config file not found, create! #{config_file.inspect}"
      end
    end
  end
    
  def self.save(filename)
    File.open(filename, 'w'){|f| f.write YAML.dump(@@configs) }
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
        @configs[name.to_sym] = block || OpenStruct.new(:host => params[0], :port => params[1].to_i)
      else
        params = params[0] if params.size == 1
        @configs[name.to_sym] = block || params
      end
    end
  end

  def self.[]=(option, value)
    @@configs[option.to_sym] = value
  end
  
  def self.has_key?(key)
    @@configs.key?(key.to_sym)
  end
  
  def self.try(method)
    self.send(method) rescue nil
  end

  def self.method_missing(name, *args)
    if has_key?(name)
      res = @@configs[name.to_sym]
      res.is_a?(Proc) ? res.call : res      
    else
      super
    end
  end
end
