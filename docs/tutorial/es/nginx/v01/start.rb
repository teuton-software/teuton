group "Comprobar el servicio web Nginx" do
  readme "* Necesitamos un SO GNU/Linux basado en systemd. Por ejemplo: OpenSUSE, Debian, etc."

  target "Comprobar el estado del servicio Nginx", weight: 3
  run "systemctl status nginx"
  expect "Active: active (running)"

  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 5
  readme "Se asume que Nginx está instalado en su ruta por defecto."
  run "cat /var/www/html/index.html"
  expect "Hola Mundo!"
end

start do
  show
  export
end
