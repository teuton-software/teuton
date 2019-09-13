
require_relative '../../application'

module Lang
  def self.get(key)
    lang = {}
    lang['en'] = {
      testname: 'Challenge name : %s',
      date:     'Date           : %s',
      version:  'Teuton version : %s',
      params:   "\nParams configured for every case:",
      hosts:    "\nRequired hosts:",
      goto:     'Go to %s host, and do next:'
    }
    lang['es'] = {
      testname: 'Nombre del reto   : %s',
      date:     'Fecha             : %s',
      version:  'Versión de Teuton : %s',
      params: "\nParámetros de configuración de cada caso:",
      hosts: "\nMáquinas que se necesitan:",
      goto: 'Ir a la máquina %s, y hacer lo siguiente:'
    }
    locale = Application.instance.options['lang'].downcase
    lang[locale][key]
  end
end
