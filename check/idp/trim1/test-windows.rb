
task "Windows7 - grupos" do
  grupos = ['personajes', 'humanos', 'enemigos']

  goto   :host1, :exec => "net localgroup"
  grupos.each do |grupo|
    target "Existe el grupo <#{grupo}>"
    result.restore!
    expect result.find!("*"+grupo).count!.eq 1
  end
end

task "Windows7 - usuarios" do
  usuarios = ['mario', 'princesa', 'tortuga', 'seta']

  usuarios.each do |usuario|
    target "Existe el usuario <#{usuario}> y es miembro de <personajes>"
    goto   :host1, :exec => "net user #{usuario}"
    expect result.find!('*personajes').count!.eq 1
  end

  grupo = 'humanos'
  usuario = 'mario'
  target "El usuario <#{usuario}> es miembro del grupo <#{grupo}>"
  goto   :host1, :exec => "net user #{usuario}"
  expect result.find!('*'+grupo).count!.eq 1

  grupo = 'humanos'
  usuario = 'princesa'
  target "El usuario <#{usuario}> es miembro del grupo <#{grupo}>"
  goto   :host1, :exec => "net user #{usuario}"
  expect result.find!('*'+grupo).count!.eq 1

  grupo = 'enemigos'
  usuario = 'tortuga'
  target "El usuario <#{usuario}> es miembro del grupo <#{grupo}>"
  goto   :host1, :exec => "net user #{usuario}"
  expect result.find!('*'+grupo).count!.eq 1

  grupo = 'enemigos'
  usuario = 'seta'
  target "El usuario <#{usuario}> es miembro del grupo <#{grupo}>"
  goto   :host1, :exec => "net user #{usuario}"
  expect result.find!('*'+grupo).count!.eq 1
end

task "Windows7 - directorios" do
  usuarios = ['mario', 'princesa', 'tortuga', 'seta']

  goto   :host1, :exec => "dir c:\\Users"
  usuarios.each do |usuario|
    target "Existe directorio home del usuario <#{usuario}>"
    result.restore!
    expect result.find!(usuario).count!.eq 1
  end
end

task 'Windows7 - permisos' do

  dirnames = ['casa.d','plataformas.d']
  dirnames.each do |dirname|
    target "El directorio <#{dirname}> tiene control total para el usuario <mario>"
    goto   :host1, :exec => "icacls c:\\Users\\mario\\#{dirname}"
    expect result.find!('mario').find!('(F)').count!.eq 1
  end

  dirname = "casa.d"
  target "El directorio <#{dirname}> NO tiene permisos para el grupo Todos"
  goto   :host1, :exec => "icacls c:\\Users\\mario\\#{dirname}"
  expect result.find!('Todos').count!.eq 0

  dirname = "plataformas.d"
  target "El directorio <#{dirname}> tiene lectura el grupo Todos"
  goto   :host1, :exec => "icacls c:\\Users\\mario\\#{dirname}"
  expect result.find!('Todos').find!('(RX)').count!.eq 1
end
