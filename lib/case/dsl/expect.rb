# encoding: utf-8

module DSL

  #expect <condition>, :weight => <value>
  def expect(pCond, pArgs={})
    weight(pArgs[:weight])
    lWeight= @action[:weight]

    @action_counter+=1
    @action[:id]=@action_counter
    @action[:weight]=lWeight
    @action[:check]=pCond
    @action[:result]=@result.value

    @action[:alterations]=@result.alterations
    @action[:expected]=@result.expected
    @action[:expected]=pArgs[:expected] if pArgs[:expected]

    @report.lines << @action.clone
    weight(1.0)

    app=Application.instance
    c=app.letter[:bad]
    c=app.letter[:good] if pCond
    verbose c
  end

end
