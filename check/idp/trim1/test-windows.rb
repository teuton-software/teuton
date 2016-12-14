
task "Windows7 - grupos" do
  grupos = ['personajes', 'humanos', 'enemigos']

  goto   :host1, :exec => "net localgroup"
  grupos.each do |grupo|
    target "Existe el grupo <#{usuario}>"
    result.restore!
    expect result.find!("*"+grupo).count!.eq 1
  end
end

task "Windows7 - usuarios" do
  usuarios = ['mario', 'princesa', 'tortuga', 'seta']

  usuarios.each do |usuario|
    target "Existe el usuario <#{usuario}>"
    goto   :host1, :exec => "net user #{usuario}"
    expect result.find!(usuario).count!.gt 0
  end

  goto   :host1, :exec => "dir c:\\Users"
  usuarios.each do |usuario|
    target "Existe directorio home del usuario <#{usuario}>"
    result.restore!
    expect result.find!(usuario).count!.eq 1
  end
end
