# frozen_string_literal: true

require 'net/ssh'

# Detect remote OS type and suggest remote temp folder
module OSType
  def self.detect(session)
    raise 'OSType#detect' unless session.class == Net::SSH::Connection::Session

    text = session.exec!('uname -a')
    return gnulinux_detected if text.include? 'GNU/Linux'

    return macos_detected if text.include? 'Darwin'

    text = session.exec!('ver')
    return windows_detected if text.include? 'Windows'

    puts '[ERROR] OSType#detect: Unknown OSType!'
    { ostype: :unknown, remotefolder: nil }
  end

  def self.gnulinux_detected(session)
    session.exec!('mkdir /tmp/teuton')
    { ostype: :gnulinux, remotefolder: '/tmp/teuton' }
  end

  def self.macos_detected(session)
    session.exec!('mkdir /tmp/teuton')
    { ostype: :macos, remotefolder: '/tmp/teuton' }
  end

  def self.windows_detected(session)
    session.exec!('mkdir %windir%\temp\teuton')
    text = session.exec!('echo "%windir%\temp\teuton"')
    { ostype: :windows, remotefolder: text.strip! }
  end
end
