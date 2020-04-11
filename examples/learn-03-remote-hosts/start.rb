
group "How to test remote Windows hosts" do

  target "Update hostname with #{gett(:host1_hostname)}"
  goto   :host1, :exec => "hostname"
  expect_one get(:host1_hostname)

  target "Ensure network DNS configuration is working"
  goto   :host1, :exec => "nslookup www.google.es"
  expect "Nombre:"

  target "Create user #{gett(:username)}"
  goto   :host1, :exec => "net user"
  expect get(:username)

end

play do
  show
  # export using other output formats
  export :format => :colored_text
  export :format => :json
  send :copy_to => :host1
end
