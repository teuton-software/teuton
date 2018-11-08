
task "ACL usuarios y grupos" do

  rebels = [`han`, `luke`]
  troopers = [`trooper1`, `trooper2`]
  usuarios = rebels + troopers

  usuarios.each do |usuario|
    target "Existe usuario <#{usuario}>"
    goto :debian1, :exec => "id #{usuario}"
    expect result.count.eq 1
  end

  rebels.each do |usuario|
    target "Usuario <#{usuario}> en el grupo rebels"
    goto :debian1, :exec => "id #{usuario}"
    expect result.grep("rebels").count.eq 1
  end

  troopers.each do |usuario|
    target "Usuario <#{usuario}> en el grupo troopers"
    goto :debian1, :exec => "id #{usuario}"
    expect result.grep("troopers").count.eq 1
  end

end
