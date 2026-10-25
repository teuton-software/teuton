# frozen_string_literal: true

class Case
  def close(uniques)
    # Invoked from check_cases!
    @action_manager.close(@report)

    fails = 0
    uniques.each_pair do |key, values|
      next unless values&.include?(id) && (values&.count&.> 1)

      fails += 1
      log_unique_message(key, values)
    end
    @report.tail[:unique_fault] = fails
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
