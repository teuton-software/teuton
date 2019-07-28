# frozen_string_literal: true

require_relative 'group_model'

# Case::CaseModel class => save case internal data
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

  def targets_counter
    counter = 0
    @groups.each { |g| counter += g.targets.size }
    counter
  end
end
