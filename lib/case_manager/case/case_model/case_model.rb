
require_relative 'group_model'

class CaseModel
  def initialize
    @groups = []
    @current_group = nil
  end

  def group
    @current_group
  end

  def group_new(name)
    @current_group = GroupModel.new(name)
    @groups << @current_group
  end
end
