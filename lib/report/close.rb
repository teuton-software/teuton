
# Close Show methods for Report class.

class Report

  def close
    app = Application.instance
    lMax = 0.0
    lGood = 0.0
    lFail = 0.0
    lFailCounter = 0
    @lines.each do |i|
      if i.class.to_s == 'Hash'
        lMax += i[:weight] if i[:weight]>0
        if i[:check]
          lGood += i[:weight]
          @history += app.letter[:good]
        else
          lFail += i[:weight]
          lFailCounter += 1
          @history += app.letter[:bad]
        end
      end
    end
    @tail[:max_weight] = lMax
    @tail[:good_weight] = lGood
    @tail[:fail_weight] = lFail
    @tail[:fail_counter] = lFailCounter

    i = lGood.to_f / lMax.to_f
    i = 0 if i.nan?
    @tail[:grade] = (100.0 * i).round
    @tail[:grade] = 0 if @tail[:unique_fault]>0
  end
end
