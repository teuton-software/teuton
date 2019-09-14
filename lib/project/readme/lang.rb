
require_relative '../../application'

module Lang
  def self.get(key)
    lang = {}
    lang['en'] = {
      version:  'Teuton version : %s',
      testname: 'Challenge name : %s',
      date:     'Date           : %s',
      params:   "\nRequired configuration params:",
      hosts:    "\nRequired hosts:",
      goto:     'Go to %s host, and do next:',
      global:   "\nGlobal parameters that can be modified:"
    }
    lang['es'] = {
      version:  'Versión de Teuton : %s',
      testname: 'Nombre del reto   : %s',
      date:     'Fecha             : %s',
      params:   "\nParámetros de configuración necesarios:",
      hosts: "\nMáquinas que se necesitan:",
      goto: 'Ir a la máquina %s, y hacer lo siguiente:',
      global:   "\nParámetros globales que pueden ser modificados:"
    }
    locale = Application.instance.options['lang'].downcase
    lang[locale][key]
  end
end
