[<< back](README.md)

# Example: 14-alias

Supongamos que tenemos un test como el siguiente:

```ruby
group "Using alias" do
  target "Verify user #{get(:super)} with key alias."
  run "id #{get(:super)}"
  expect get(:super)

  target "Verify user #{_username} with method alias."
  run "id #{_username}"
  expect _username
end
```

Tenemos sólo 2 targets pero podríamos tener muchos más.

> Recordemos que `_username` es equivalente a `get(:username)`

Sabemos que el fichero de configuración debe definir los valores para los parámetros `super` y `username`. Queremos aprovechar un fichero de configuración que ya teníamos de otro test, pero tiene el siguiente contenido:

```yaml
# Version 1
# File: config.yaml
global:
cases:
- tt_members: Anonymous
  superuser: root
  username: obiwan
```

Podemos comprobar que nuestro test require el parámetro `super` pero el fichero de configuración lo ha nombrado como `superuser`.

```yaml
# Version 2
# File: config.yaml
alias:
  super: :superuser
global:
cases:
- tt_members: Anonymous
  superuser: root
  username: obiwan
```
