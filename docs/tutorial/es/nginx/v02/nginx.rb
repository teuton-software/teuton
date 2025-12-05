# File: nginx.rb (Tests específicos de Nginx)

group "Comprobar el servicio web Nginx" do
  readme "* Necesitamos un SO GNU/Linux basado en systemd. Por ejemplo: OpenSUSE, Debian, etc."

  target "Comprobar el estado del servicio Nginx", weight: 3
  run "systemctl status nginx", on: :webserver
  expect "Active: active (running)"

  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 5
  readme "Se asume que Nginx está instalado en su ruta por defecto."
  run "cat /var/www/html/index.html", on: :webserver
  expect "Hola Mundo!"
end
