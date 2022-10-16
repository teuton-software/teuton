
# guess_os: Adivinar el sistema operativo

## Situación actual

Cuando usamos `Teuton`, escribimos comandos que se ejecutarán en el host que deseamos monitorizar/evaluar. Estos comandos sabemos cómo escribirlos porque conocemos de antemano el SO de nuestro host.

`Teuton` (de momento) no tiene la capacidad de "adivinar" el SO del host, ni aún conociéndolo, tampoco tiene el conocimiento para saber qué comandos son válidos para cada SO, ni cómo convertir comandos de un SO en otro.

## Propuesta

A pesar de todo, al recibir solicitudes en esta línea nos hemos puesto a trabajar en un módulo para intentar "adivinar" el SO de una máquina local o remota(SSH), y hemos creado [guess_os](https://rubygems.org/gems/guess_os).

Es la primera versión y de momento sólo reconoce correctamente algunos SO/versiones pero no todos. Tiene mucho que mejorar y por este motivo les pedimos un poco de colaboración (sólo te llevará unos minutos).

1. Instalar `guess_os` en tu equipo (`gem install --user-install guess_os`).
2. Ejecutar el comando `guess_os`.
3. Pulsar ENTER en la pregunta de IP, para adivinar el SO de la máquina local (localhost).
    * Si el resultado devuelto coincide con la realidad ¡Estupendo! Ya puedes desintalar la gema si quieres (`gem uninstall guess_os`) o la puedes seguir probando y reportarnos fallos/ideas/mejoras/etc.
    * Si el resultado devuelto NO coincide con lo que debe salir... entonces envíanos los datos de tu sistema y los que devuelve `guess_os` para ir mejorando esta herramienta.

¡Gracias!

```
Contacto
  email    : teuton.software@protonmail.com
  Telegram : @TeutonSoftware
```
