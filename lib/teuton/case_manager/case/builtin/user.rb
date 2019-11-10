
class User
  attr_accessor :param

  def initialize(parent)
    @parent = parent
  end

  def exists?
    @parent.target("User #{@param} exists?")
    @parent.run "id #{@param}"
    @parent.expect_one @param
  end

  def is_member_of?(groupname)
    @parent.target("User #{@param} is member of #{groupname}?")
    @parent.run "id #{@param}"
    @parent.expect_one [@param, groupname]
  end
end
