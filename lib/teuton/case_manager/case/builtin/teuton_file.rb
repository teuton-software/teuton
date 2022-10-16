
class TeutonFile
  def initialize(teuton_host, param)
    @teuton_host = teuton_host
    @parent = teuton_host.parent
    @result = @parent.result
    @host = teuton_host.host
    @param = param
  end

  def exist?
    @parent.target("File #{@param} exists?")
    @parent.run "file #{@param}", on: @host
    @parent.expect @result.grep_v("cannot open").grep(@param).count.eq 1
  end

  def directory?
    @parent.target("File #{@param} is directory?")
    @parent.run "file #{@param}", on: @host
    @parent.expect @result.grep_v("cannot open").grep(@param).grep("directory").count.eq 1
  end

  def regular?
    @parent.target("File #{@param} is regular?")
    @parent.run "file #{@param}", on: @host
    @parent.expect @result.grep(@param).grep("directory").count.eq 0
  end
end
