
class CaseManager

  def show(mode = :resume)
    @report.show if mode == :resume || mode == :all
    if mode == :details || mode == :all
      @cases.each do |c|
        puts '____'
        c.report.show
      end
      puts '.'
    end
  end

end
