
group "learn-07-builtin" do
  host(:host1).service('firewalld').is_running?
  host(:host1).service('sshd').is_running?

  h1 = host(:host1)
  h1.package('geany').installed?
  h1.package('basic').installed?

  u1 = h1.user('root')
  u1.exists?
  u1.is_member_of? 'users'

  host(:host1).file('/etc').exist?
  host(:host1).file('/etc').directory?
end

play do
  show
  export format: :colored_text
end
