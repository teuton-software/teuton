
task :disk_size do
  size='18'
  target "Disk sda size <#{size}>"
  goto :host2, :exec => "lsblk |grep disk| grep sda| grep #{size}|grep G| wc -l"
  expect result.eq(1)
end

task :partitions_size_and_type do
  partitions={ :sda1 => ['sda1'  ,'11,7G' , '12G'],
               :sda2 => ['sda2'  ,'100M' , '100M'],
               :sda5 => ['[SWAP]','500M', '500M'],
               :sda6 => ['/home' ,'100M', '107M'],
               :sda7 => ['/'     ,'5G', '5,3G']
                }

  partitions.each_pair do |key,value|
    target "Partition #{key} mounted on <#{value[0]}>"
    goto :host2, :exec => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.eq(1)

    target "Partition #{key} size <#{value[1]}>"
    goto :host2, :exec => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))
  end

  partitions={ :sda6 => ['/dev/disk', '/home', 'ext3'],
               :sda7 => ['/dev/disk', '/'    , 'ext4']
             }

  partitions.each_pair do |key,value|
     target "Partition #{key} type <#{value[2]}>"
    goto :host2, :exec => "df -hT | grep #{key}| grep #{value[2]}|wc -l"
    expect result.eq(1)
  end
end
