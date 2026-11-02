group "Unique value: hostname" do
  run "hostname -f", on: :host1
  unique "Host name", result.value
end
