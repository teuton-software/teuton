
class User
  def initialize(teuton_host, param)
    @teuton_host = teuton_host
    @parent = teuton_host.parent
    @host = teuton_host.host
    @param = param
  end

  def exists?
    @parent.target("User #{@param} exists?")
    @parent.run "id #{@param}", on: @host
    @parent.expect_one [ 'uid=', @param ]
  end

  def is_member_of?(groupname)
    @parent.target("User #{@param} is member of #{groupname}?")
    @parent.run "id #{@param}", on: @host
    @parent.expect_one [@param, groupname]
  end
end
