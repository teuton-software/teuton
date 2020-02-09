
group "learn-07-builtin" do
  service('firewalld').is_running?
  service('sshd').is_running?

  user('root').exists?
  user('david').exists?

  package('geany').installed?
  package('basic').installed?
end

play do
  show
  export
end
