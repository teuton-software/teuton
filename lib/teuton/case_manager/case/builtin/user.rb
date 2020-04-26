
class User
  attr_accessor :param

  def initialize(parent, host = 'localhost')
    @parent = parent
    @host = host
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
