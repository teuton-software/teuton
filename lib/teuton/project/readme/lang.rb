
require_relative '../../application'

module Lang
  def self.get(key)
    lang = {}
    lang['en'] = {
      version:  'Teuton version : %s',
      testname: 'Test unit name : %s',
      date:     'Date           : %s',
      hosts:    "\n\#\#\# Required hosts\n",
      params:   "\n\#\#\# Required params\n",
      goto:     "\nGo to [%s](\#required-hosts) host, and do next:\n",
      global:   "\nGlobal parameters that can be modified:\n",
      created:  "\nParams created during challenge execution:\n"
    }
    lang['es'] = {
      version:  'Versión de Teuton : %s',
      testname: 'Nombre del test   : %s',
      date:     'Fecha             : %s',
      hosts:    "\n\#\#\# Máquinas que se necesitan\n",
      params:   "\n\#\#\# Parámetros de necesarios\n",
      goto:     "\nIr a la máquina [%s](\#required-hosts), y hacer lo siguiente:\n",
      global:   "\nParámetros globales que pueden ser modificados:\n",
      created:  "\nParámetros creados durante la ejecución del reto:\n"
    }
    locale = Application.instance.options['lang'].downcase
    lang[locale][key]
  end
end
