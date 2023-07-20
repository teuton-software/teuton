define_macro "run_script", :file, :shell, :args, :on do
  command = "#{_shell} #{_file} #{_args}"
  run_file command, on: _on
end
