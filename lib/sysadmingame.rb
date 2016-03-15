# encoding: utf-8

require_relative 'tool'

def check(name, &block)
  Tool.instance.define_test(name, &block)
end

def start(&block)
  Tool.instance.start(&block)
end
