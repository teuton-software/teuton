# encoding: utf-8

module Puppet

  def self.exist_user?(username, args={})
    output = {}
    output[:target] = "Extern Puppet: exists user <#{username}>"
    hostname = 'localhost'
    hostname = args[:on] if args[:on]
    command = "jajaja"
    output[:goto] = "goto #{hostname}, :exec => #{command}"
    output[:expect] = "expect result.grep(#{username}).count.eq 1"
    output
  end

end
