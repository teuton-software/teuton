# encoding: utf-8

require_relative 'application'
require_relative 'tool'

def task(name, &block)
  Application.instance.tasks << { :name => name, :block => block }
end

def start(&block)
  Tool.instance.start(&block)
end
