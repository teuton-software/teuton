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
    puts Rainbow("SEND REPORTS").bright
    write("-" * 70)
    write("Started at #{Time.new}")

    cases.each { |c| threads << Thread.new { c.send(@logfile, args) } }
    threads.each(&:join)

    write("Finished!")
    puts "-" * 70
  end

  private

  def write(msg)
    puts msg
    @logfile.write "#{msg}\n"
    @logfile.flush
  end
end
