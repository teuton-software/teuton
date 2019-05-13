class CaseModel
  # Case::CaseModel::TargetModel => save internal target data
  class TargetModel
    attr_accessor :description, :asset
    attr_accessor :hostname, :command, :encoding, :duration
    attr_accessor :id, :weight, :check, :result, :alterations, :expected

    def initialize(desc = 'No description!', args = {})
      # target
      @description = desc
      @asset = args[:asset]
      reset_goto_attr
      reset_expect_attr
    end

    private

    def reset_goto_attr
      # goto
      @hostname = ''
      @command = ''
      @encoding = 'UTF-8'
      @duration = 0
    end

    def reset_expect_attr
      # expect
      @id = 0
      @weight = 1.0
      @check = false
      @result = ''
      @alterations = ''
      @expected = ''
    end
  end
end
