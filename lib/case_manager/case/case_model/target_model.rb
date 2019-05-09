
class CaseModel
  class TargetModel
    attr_accessor :description, :asset
    attr_accessor :hostname, :command, :encoding, :duration
    attr_accessor :id, :weight, :check, :result, :alterations, :expected

    def initialize(description, args={})
      # target
      @description = description
      @asset = args[:asset]

      # goto
      @hostname = ''
      @command = ''
      @encoding = 'UTF-8'
      @duration = 0

      # expect
      @id = 0
      @weight = 1
      @check = false
      @result = ''
      @alterations = ''
      @expected = ''
    end
  end
end
