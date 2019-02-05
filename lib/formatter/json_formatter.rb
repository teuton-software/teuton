# encoding: utf-8

require 'terminal-table'
require_relative 'base_formatter'

class JSONFormatter < BaseFormatter

  def initialize(pReport)
    super(pReport)
    @data = {}
  end

  def process
    head = {}
    head[:title] = "INITIAL CONFIGURATIONS"
    @head.each { |key,value| head[key]=value.to_s }

    body = {}
    body[:title] = "HISTORY"
    body[:lines] = []

    @lines.each do |i|
      line = ""
      if i.class.to_s=='Hash' then
        lValue=0.0
        if i[:check]
          lValue=i[:weight]
        end

        line = {}
        line[:id]          = "%02d"%i[:id]+" ("+lValue.to_s+"/"+i[:weight].to_s+")"
        line[:description] = i[:description].to_s
        line[:command]     = i[:command].to_s
        line[:duration]    = i[:duration].to_s
        line[:alterations] = i[:alterations].to_s
        line[:expected]    = i[:expected].to_s
        line[:result]      = i[:result].to_s
      else
        line = i.to_s
      end
      body[:lines] << line
    end

    tail = {}
    tail[:title] = "FINAL VALUES"
    @tail.each { |key,value| tail[key] = value.to_s }

    fame = {}
    fame[:title] = "HALL OF FAME"
    app=Application.instance
    app.hall_of_fame.each { |line| fame[line[0]] = line[1] }

    # Compose data ouput
    @data[:head] = head
    @data[:body] = body
    @data[:tail] = tail
    @data[:fame] = fame
    w @data.to_json # Write data into ouput file
    deinit
  end

end
