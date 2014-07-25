#!/usr/bin/ruby
# encoding: utf-8

require 'pony'

#Gmail example (with TLS/SSL)

Pony.mail(:to => 'dvarrui@gmail.com', 
          :subject => "test_email.rb",
          :body => "Mensaje de prueba desde test_email.rb"+Time.now.to_s,
          :via => :smtp, 
          :via_options => {
						:address              => 'smtp.gmail.com',
						:port                 => '587',
						:enable_starttls_auto => true,
						:user_name            => 'teachertools.tenerife@gmail.com',
						:password             => '.daviDUBI2010',
						#:authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
						:domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  })

