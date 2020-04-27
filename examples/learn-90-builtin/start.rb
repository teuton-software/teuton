
group "learn-07-builtin" do
  host(:host1).service('firewalld').is_running?
  host(:host1).service('sshd').is_running?

  h1 = host(:host1)
  h1.user('root').exists?
  h1.user('david').exists?

  p1 = h1.package('geany')
  p1.installed?

  p2 = h1.package('basic')
  p2.installed?
end

play do
  show
  export format: :colored_text
end
