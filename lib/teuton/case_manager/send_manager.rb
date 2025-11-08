require "rainbow"

class SendManager
  def initialize
    logpath = File.join(Project.value[:output_basedir], Project.value[:test_name], "send.log")
    @logfile = File.open(logpath, "a")
  end

  ##
  # Execute "send" order: Copy every case report to remote hosts
  # @param args (Hash) Send options
  def call(cases, args)
    threads = []
    puts ""
    write("-" * 70, :green)
    write("Started at #{Time.new}", :green)
    write("Sending reports to reachable hosts. Options=#{args}", :green)

    cases.each { |c| threads << Thread.new { c.send(@logfile, args) } }
    threads.each(&:join)

    write("Finished!", :green)
    puts Rainbow("-" * 70).green
  end

  private

  def write(msg, color)
    puts Rainbow(msg).color(color)
    @logfile.write "#{msg}\n"
    @logfile.flush
  end
end
