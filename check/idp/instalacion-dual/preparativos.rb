
task "Settings" do
  set(:linux1_ip, get(:suse1_ip))
  set(:linux1_username, get(:suse1_username))
  set(:linux1_password, get(:suse1_password))
end

tak "Ensure UNIQUE values" do
  goto :suse1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :suse1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :suse1, :exec => "blkid |grep sda6"
  unique "UUID_sda6", result.value
  goto :suse1, :exec => "blkid |grep sda7"
  unique "UUID_sda7", result.value
end
