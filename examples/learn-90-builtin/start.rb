
group "learn-07-builtin" do
  service('firewalld', :host1).is_running?
  service('sshd', :host1).is_running?

  user('root', :host1).exists?
  user('david', :host1).exists?

  package('geany', :host1).installed?
  package('basic', :host1).installed?
end

play do
  show
  export format: :colored_text
end
