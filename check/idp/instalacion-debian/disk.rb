
task :disk_size do
  size='10G'
  target "Disk sda size <#{size}>"
  goto  :host1, :exec => "lsblk |grep disk| grep sda| grep #{size}| wc -l"
  expect result.eq(1)
end

task :partitions_size_and_type do
  partitions={ :sda5 => ['[SWAP]','953M', '952M'],
               :sda6 => ['/'     ,'6,5G', '6,5G'],
               :sda7 => ['/home' ,'476M', '475M'],
               :sda8 => ['sda8'  ,'94M' , '93M']
                }

  partitions.each_pair do |key,value|
    target "Partition #{key} mounted on <#{value[0]}>"
    goto  :host1, :exec => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.eq(1)

    target "Partition #{key} size <#{value[1]}>"
    goto  :host1, :exec => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))
  end

  partitions=[ ['/dev/disk', '/', 'ext4'], ['/dev/disk', '/', 'ext4']  ]

  partitions.each do |p|    
    target "Partition #{p[1]} type <#{p[2]}>"
    goto  :host1, :exec => "df -hT | grep #{p[0]} | grep #{p[1]}| grep #{p[2]}|wc -l"
    expect result.eq(1)
  end

end
