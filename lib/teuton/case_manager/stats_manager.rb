require_relative "../utils/project"

class StatsManager
  def initialize
    filepath = File.join(Project.value[:output_basedir], Project.value[:test_name], "stats.txt")
    @file = File.open(filepath, "w")
  end

  def call(cases)
    write "STATS"
    write("Started at #{Time.new}")

    # targets = {}
    cases.each do |acase|
      write acase.id
    end

    write("Finished!")
  end

  private

  def write(msg)
    @file.write "#{msg}\n"
  end
end
