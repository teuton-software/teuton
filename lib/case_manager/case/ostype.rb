
require 'net/ssh'

# Detect remote OS type and suggest remote temp folder
module OSType
  def self.detect(session)
    raise 'OSType#detect' unless session.class == Net::SSH::Connection::Session
    text = session.exec!('uname -a')
    if text.include? 'GNU/Linux'
      session.exec!('mkdir /tmp/teuton')
      return { ostype: :gnulinux, remotefolder: '/tmp/teuton' }
    elsif text.include? 'Darwin'
      session.exec!('mkdir /tmp/teuton')
      return { ostype: :macos, remotefolder: '/tmp/teuton' }
    end
    text = session.exec!('ver')
    if text.include? 'Windows'
      session.exec!('mkdir %windir%\temp\teuton')
      text = session.exec!('echo "%windir%\temp\teuton"')
      return { ostype: :windows, remotefolder: text.strip! }
    end
    puts '[ERROR] OSType#detect: Unknown OSType!'
    { ostype: :unknown, remotefolder: nil }
  end
end
