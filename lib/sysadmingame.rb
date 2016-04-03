# encoding: utf-8

require_relative 'tool'

def task(name, &block)
  Tool.instance.define_task(name, &block)
end

def start(&block)
  Tool.instance.start(&block)
end
