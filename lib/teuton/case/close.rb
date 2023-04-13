# frozen_string_literal: true

class Case
  def close(uniques)
    # Invoked from check_cases!

    fails = 0
    @uniques.each do |key|
      next unless uniques[key].include?(id) && uniques[key].count > 1

      fails += 1
      log_unique_message(key, uniques[key])
    end
    @report.tail[:unique_fault] = fails
    @report.close
  end

  private

  def log_unique_message(key, value)
    log("UNIQUE:", :error)
    begin
      log("   ├── Value     => #{key}", :error)
      log("   └── Conflicts => #{value}", :error)
    rescue => e
      log(key, :error)
      log(e.to_s, :error)
    end
  end
end
