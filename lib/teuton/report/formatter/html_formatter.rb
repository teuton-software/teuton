
require_relative 'base_formatter'

class HTMLFormatter < BaseFormatter

  def initialize(pReport)
    super(pReport)
  end

  def process
    puts "<html>"
    puts "<head><title>Checking Machines</title></head>"
    puts "<body>"
    puts "<header><h1><a name=\"index\">Checking Machines v0.4</a></h1>"
    puts '<ul>'
    @head.each do |key,value|
      puts "<li><b>"+key.to_s+": </b>"+value.to_s+"</li>" if key!=:title
    end
    puts '</ul>'
    puts "<table border=1 >"
    puts "<thead><tr><td>Members</td><td>Grade</td><td>Fails</td></tr></thead>"
    puts "<tbody>"

    counter=0
    @datagroups.each do |i|
      counter+=1
      puts "<tr><td><a href=\"#group"+counter.to_s+"\">"+i.head[:members]+"</a></td>"
      puts "<td>"+i.tail[:grade].to_s+"</td>"
      puts "<td>"+i.tail[:fail_counter].to_s+"</td></tr>"
    end
    puts "</tbody></table></header>"
    puts "<h1>Cases</h1>"

    counter=0
    @datagroups.each do |i|
      counter+=1
      process_datagroup(i,counter)
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
