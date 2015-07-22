# encoding: utf-8

require_relative 'checker'

def define_test(name, &block)
  Checker.instance.define_test(name, &block)
end

def start(&block)
  Checker.instance.start(&block)
end

