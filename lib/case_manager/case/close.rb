
class Case

  def close(uniques)
    fails = 0
    @uniques.each do |key|
      if uniques[key].include?(id) and uniques[key].count>1 then
        fails+=1
        log("UNIQUE:", :error)
        begin
          log("   ├── Value     => #{key.to_s}", :error)
         rescue Exception => e
          log(key, :error)
          log(e.to_s, :error)
        end
        begin
          log("   └── Conflicts => #{uniques[key].to_s}", :error)
         rescue Exception => e
          log(e.to_s, :error)
        end
      end
    end
    @report.tail[:unique_fault]=fails
    @report.close
  end

end
