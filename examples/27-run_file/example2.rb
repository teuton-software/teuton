# Example 2
#   Using DSL to define run_script macro
#   wrapping run_file
#
define_macro "run_script", :file, :shell, :args, :on do
  command = "#{_shell} #{_file} #{_args}"
  run_file command, on: _on
end

group "Using run_file with macro" do
  target "Example 4: using macro"
  run_script file: "script/show.sh", shell: "bash", args: "HelloWorld4", on: :host1
  expect "HelloWorld4"
end
