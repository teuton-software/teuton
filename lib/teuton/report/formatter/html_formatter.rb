# frozen_string_literal: true

require_relative 'yaml_formatter'

##
# HTMLFormatter class receive a [Report] and generates HAML output.
class HAMLFormatter < YAMLFormatter
  ##
  # Class constructor
  # @param report [Report] Parent object that contains data to be exported.
  def initialize(report)
    super(report)
    @data = {}
  end

  ##
  # Process data from parent object and export it into YAML format.
  # @return [nil]
  def process
    build_data
    # w @data.to_yaml # Write data into ouput file
    build_page
    deinit
  end

  def build_page
    puts "<html>"
    puts "<head><title>TEUTON report</title></head>"
    puts "<body>"
    build_config
    build_targets
    build_results
  end

  def build_config
    puts "<header><h1><a name=\"index\">Checking Machines v0.4</a></h1>"
    puts '<ul>'
    @data[:head].each do |key,value|
      puts "<li><b>"+key.to_s+": </b>"+value.to_s+"</li>" if key!=:title
    end
    puts '</ul>'
    puts "<table border=1 >"
    puts "<thead><tr><td>Members</td><td>Grade</td><td>Fails</td></tr></thead>"
    puts "<tbody>"

    counter=0
    @data[:groups].each do |group|
      group[:targets].each do |target|
      counter+=1
        puts "<tr><td><a href=\"#group"+counter.to_s+"\">"+target.head[:members]+"</a></td>"
      puts "<td>"+target[:tail][:grade]+"</td>"
      puts "<td>"+target[:tail][:fail_counter]+"</td></tr>"
    end
    puts "</tbody></table></header>"
    puts "<h1>Cases</h1>"

    counter=0
    @data[:groups].each do |group|
      counter += 1
      process_datagroup(group, counter)
    end

    puts '<ul>'
    @tail.each do |key,value|
      puts "<li><b>"+key.to_s+": </b>"+value.to_s+"</li>"
    end
    puts '</ul>'
    puts "</body></html>"
  end

  def process_datagroup(pGroup, pCounter)
    puts "<h2><a name=\"group"+pCounter.to_s+"\">Case members "+@head[:members]+"</a> (<a href=\"#index\">up</a>)</h2>"
    puts "<table border=1 >"
    puts "<thead><tr><td>Params</td><td>Results</td></tr></thead>"
    puts "<tbody><tr>"
    puts "<td><ul>"
    pGroup.head.each do |key,value|
      puts "<li><b>"+key.to_s+"</b>= "+value.to_s+"</li>" if key!=:members
    end
    puts "</ul></td>"
    puts '<td><ul>'
    pGroup.tail.each do |key,value|
      puts "<li><b>"+key.to_s+"</b>= "+value.to_s+"</li>"
    end
    puts '</ul></td>'

    puts '</tr></tbdody></table>'
    puts '<h3>Test log</h3>'
    puts '<ul>'
    pGroup.lines.each do |i|
      if i.class.to_s=='Hash' then
        value=0.0
        value=i[:weight] if i[:check]
        a="<li>"+i[:id].to_s+" ("+value.to_s+") [weight="+i[:weight].to_s+"] "
        a+="<i>"+i[:description]+"</i>: "+i[:command]+"</li>"
        puts a
      else
        puts "<li>"+i.to_s+"</li>"
      end
    end
    puts '</ul>'
  end
end
end
