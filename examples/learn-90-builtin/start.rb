
group "learn-07-builtin" do
  host(:host1).service('firewalld').is_running?
  host(:host1).service('sshd').is_running?

  host(:host1).user('root').exists?
  host(:host1).user('david').exists?

  host(:host1).package('geany').installed?
  host(:host1).package('basic').installed?
end

play do
  show
  export format: :colored_text
end
