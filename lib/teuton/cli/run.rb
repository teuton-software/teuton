#!/usr/bin/env ruby

require_relative "app"

module Teuton::CLI
  def self.run(argv)
    begin
      Teuton::CLI::App.start(argv)
      exit 0
    rescue Interrupt
      puts "\nExecution cancelled by the user."
      exit 130
    rescue Teuton::CaseManagerDslError => e
      lines = e.message.split("\n")
      head = lines.shift
      warn "Error | #{head}"
      lines.each { |line| warn Rainbow("Error| #{line}").white }
    rescue Teuton::ConfigFileError => e
      lines = e.message.split("\n")
      head = lines.shift
      warn "Error | #{head}"
      lines.each { |line| warn Rainbow("Error| #{line}").white }
    rescue Teuton::MainScriptNotFoundError => e
      warn "Error | #{e.message}"
    rescue Teuton::Error => e
      warn "Controlled error: #{e.message}"
      e.backtrace&.first(3)&.each do |line|
        warn Rainbow("Error |   #{line}").white
      end
    rescue => e
      warn "Unexpected error: #{e.message}"
      raise e if ENV["DEBUG"]

      e.backtrace&.first(3)&.each { |line| warn Rainbow("Error |   #{line}").white }
    end
    exit 1
  end
end
