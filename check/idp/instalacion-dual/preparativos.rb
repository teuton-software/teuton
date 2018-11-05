
task "Preparativos" do
  goto :suse1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :suse1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :suse1, :exec => "blkid |grep sda6"
  unique "UUID_sda6", result.value
  goto :suse1, :exec => "blkid |grep sda7"
  unique "UUID_sda7", result.value
end
