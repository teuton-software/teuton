# encoding: utf-8

require 'net/ssh'
require 'net/sftp'
require 'net/telnet'

require_relative 'application'

class Case

  class ExecManager
  
    def initialize(parent)
      @parent = parent

      @debug=Tool.instance.is_debug?
      @verbose=Tool.instance.is_verbose?
	
      @sessions={}

      @action=@parent.action
      @config=@parent.config
      @result=@parent.result
    end
  
    #execute("rm #{@tmpdir}/#{names}") if r[0].to_i>0 #Delete previous temp files

    def read_filename(psFilename)
      begin
        lFile = File.open(psFilename,'r')
        lItem = lFile.readlines
        lFile.close
			
        lItem.map! { |i| i.sub(/\n/,"") }
			
        return lItem
      rescue
        return []
      end
    end
	
    def run_local_cmd
      @result.content = my_execute( @action[:command] )	
    end

    def run_remote_cmd(pHostname)
      hostname=pHostname.to_s
      protocol=@config.get((hostname+'_protocol').to_sym) if @config.get((hostname+'_protocol').to_sym)
      protocol=:ssh if protocol.nil?
      protocol=protocol.to_sym
    
      case protocol
      when :ssh
        run_remote_cmd_ssh(pHostname)
      when :telnet
        run_remote_cmd_telnet(pHostname)
      else
        raise "Unkown remote protocol <#{protocol.to_s}>"
      end
    end
  	
    def run_remote_cmd_ssh(pHostname)
      app=Application.instance 		
      hostname=pHostname.to_s
      ip=@config.get((hostname+'_ip').to_sym)
      username=@config.get((hostname+'_username').to_sym)
      password=@config.get((hostname+'_password').to_sym)
      output=[]
		
      begin
        if @sessions[hostname].nil?
          @sessions[hostname] = Net::SSH.start(ip, username, :password => password)
        end
			
        if @sessions[hostname].class==Net::SSH::Connection::Session
          text=@sessions[hostname].exec!( @action[:command] )
          output = text.split("\n")
        end
      rescue Errno::EHOSTUNREACH
        @sessions[hostname]=:nosession
        verbose app.letter[:error]
        @parent.log( "Host #{ip} unreachable!", :error)
      rescue Net::SSH::AuthenticationFailed
        @sessions[hostname]=:nosession
        verbose app.letter[:error]
        @parent.log( "SSH::AuthenticationFailed!", :error)
      rescue Net::SSH::HostKeyMismatch
        @sessions[hostname]=:nosession
        verbose app.letter[:error]
        @parent.log( "SSH::HostKeyMismatch!", :error)
        @parent.log( "* The destination server's fingerprint is not matching what is in your local known_hosts file.",:error)
        @parent.log( "* Remove the existing entry in your local known_hosts file", :error)
        @parent.log( "* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{ip}", :error)
      rescue Exception => e
        @sessions[hostname]=:nosession
        verbose app.letter[:error]
        log( "[#{e.class.to_s}] SSH on <#{username}@#{ip}> exec: "+@action[:command], :error)
      end
		
      @result.content=output
      @result.content.compact!
    end

    def run_remote_cmd_telnet(pHostname) 	
      app=Application.instance
      hostname=pHostname.to_s
      ip=@config.get((hostname+'_ip').to_sym)
      username=@config.get((hostname+'_username').to_sym)
      password=@config.get((hostname+'_password').to_sym)
      output=[]

      begin
        if @sessions[hostname].nil? or @sessions[hostname]==:ok
          h = Net::Telnet::new( { "Host"=>ip, "Timeout"=>30, "Prompt"=>/sysadmingame/ })
          h.login( username, password)
          text=""
          h.cmd(@action[:command]) {|i| text << i}
          output=text.split("\n")
          h.close      
          @sessions[hostname] = :ok
        end
      rescue Net::OpenTimeout
        @sessions[hostname] = :nosession
        verbose app.letter[:error]
        log( " ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
        log( " └── Revise host IP!", :warn)
      rescue Net::ReadTimeout
        @sessions[hostname] = :nosession
        verbose app.letter[:error]
        log( " ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
      rescue Exception => e
        @sessions[hostname] = :nosession
        verbose app.letter[:error]
        log( " ExceptionType=<#{e.class.to_s}> doing telnet on <#{username}@#{ip}> exec: "+@action[:command], :error)
        log( " └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
      end

      @result.content=output
    end

    def my_execute(psCmd)
      output=[]
      return output if @debug
      begin
        text=`#{psCmd}`
        output=text.split("\n")
      rescue
        verbose "!"
        @parent.log ("Local exec: "+psCmd) #, :error)
      end
      return output
    end

    def verboseln(psText)
      verbose(psText+"\n")
    end
	
    def verbose(psText)
      return if !@verbose
      print psText
    end

  end
end
