
task "OpenSUSE - grupos" do
  grupos = ['personajes', 'humanos', 'enemigos']
  goto :host2, :exec => "cat /etc/group"
  grupos.each do |grupo|
    target "Grupo <#{grupo}>"
    result.restore!
    expect result.find!(grupo+':').count!.eq(1), :weight => 5
  end

  usuarios = ['mario', 'princesa', 'tortuga', 'seta']
  goto :host2, :exec => 'cat /etc/group'
  usuarios.each do |usuario|
    target "El usuario <#{usuario}> es miembro del grupo <personajes>"
    result.restore!
    expect result.find!('personajes').find!(usuario).count!.eq(1), :weight => 5
  end
end

task "OpenSUSE - usuarios" do
  usuarios = ['mario', 'princesa', 'tortuga', 'seta']
  usuarios.each do |usuario|
    target "Usuario <#{usuario}>"
    goto :host2, :exec => "id #{usuario}"
    expect result.find!(usuario).count!.eq(1), :weight => 5
  end

  target 'Home <princesa>'
  goto :host2, :exec => 'finger princesa'
  expect result.find!('/home/castillo/princesa').count!.eq(1), :weight => 5

  target "Grupo principal <humanos> para usuario <princesa>"
  goto :host2, :exec => 'vdir /home/castillo'
  expect result.find!('princesa').find!('humanos').count!.eq(1), :weight => 5

  target "Grupo principal <humanos> para usuario <mario>"
  goto :host2, :exec => 'vdir /home'
  expect result.find!('mario').find!('humanos').count!.eq(1), :weight => 5

  enemigos = ['tortuga', 'seta']
  enemigos.each do |usuario|
    target "Grupo principal <enemigos> para usuario <#{usuario}>"
    result.restore!
    expect result.find!(usuario).find!("enemigos").count!.eq(1), :weight => 5
  end
end

task "OpenSUSE - software" do
  programas = [ 'nano', 'tree' ]
  programas.each do |programa|
    target "Programa <#{programa}> instalado"
    goto :host2, :exec => "zypper se #{programa}"
    expect result.find!('i ').find!(programa).count!.ge(1), :weight => 5
  end

  programas = [ 'geany', 'wget' ]
  programas.each do |programa|
    target "Programa <#{programa}> NO instalado"
    goto :host2, :exec => "zypper se #{programa}"
    expect result.grep_v!('i ').find!(programa).count!.ge(1), :weight => 5
  end
end

task "OpenSUSE - permisos" do
  goto :host2, :exec => "vdir /home/mario"

  dirname = 'casa.d'
  perm = 'drwx------'
  target "Directorio <#{dirname}> con permisos <#{perm}"
  result.restore!
  expect result.find!(dirname).find!(perm).count!.eq(1), :weight => 5

  dirname = 'plataformas.d'
  perm = 'drwxrwxrwx'
  target "Directorio <#{dirname}> con permisos <#{perm}"
  result.restore!
  expect result.find!(dirname).find!(perm).count!.eq(1), :weight => 5
end
