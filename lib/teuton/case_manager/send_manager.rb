require "rainbow"

class SendManager
  def initialize
    send_logpath = File.join(Project.value[:output_basedir], Project.value[:test_name], "send.log")
    @send_logfile = File.open(send_logpath, "a")
  end

  ##
  # Execute "send" order: Send every case report
  # @param args (Hash) Send options
  def call(cases, args)
    threads = []
    puts ""
    write("-" * 62, :green)
    write("Started at #{Time.new}", :green)
    write("Sending reports to reachable hosts. Options=#{args}", :green)

    cases.each { |c| threads << Thread.new { c.send(args) } }
    threads.each(&:join)

    puts Rainbow("Finished!").green
    puts Rainbow("-" * 62).green
  end

  private

  def write(msg, color)
    puts Rainbow(msg).color(color)
    @send_logfile.write "#{msg}\n"
  end
end
