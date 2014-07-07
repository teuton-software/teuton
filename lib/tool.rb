#!/usr/bin/ruby
# encoding: utf-8

require_relative 'teacher'

def define_test(name, &block)
	Teacher.instance.define_test(name, &block)
end

def start(&block)
	Teacher.instance.start(&block)
end

