
require_relative 'group_model'

class CaseModel
  attr_reader :groups

  def initialize
    @groups = []
    @current_group = nil
  end

  def group_new(name)
    @current_group = GroupModel.new(name)
    @groups << @current_group
    @current_group
  end

  def group
    @current_group
  end

end
