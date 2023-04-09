require "rainbow"

class SendManager
  ##
  # Execute "send" order: Send every case report
  # @param args (Hash) Send options
  def run(cases, args)
    threads = []
    puts ""
    puts Rainbow("-" * 50).green
    puts Rainbow("Sending files...#{args}").color(:green)
    cases.each { |c| threads << Thread.new { c.send(args) } }
    threads.each(&:join)
    puts Rainbow("Sending finished!").color(:green)
    puts Rainbow("-" * 50).green
  end
end
