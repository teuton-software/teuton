[<<back](README.md)

# Test code

Let's test code using teuton.

## Example 1

* Ask students to give us a program that performs addition and multiplication.
* Define targets:

```ruby
# File: start.rb
group "Test code 1" do
  # Reading filepath from config file
  filepath = "./#{get(:folder)}/#{get(:filename)}"

  target "Sum"
  run "#{filepath} 3 4"
  expect [ "Sum", "7" ] # Using Array/List of required items

  target "Mul"
  run "#{filepath} 3 4"
  expect /Mul\s+=\s+12/ # Using a regular expresion
end
```

* Define config params:

```yaml
# File: config.yaml
---
global:
  folder: examples/23-test-code/code
cases:
- tt_members: student_1
  filename: math_1.py
- tt_members: student_2
  filename: math_2b.py
```

* Put students files into `code` folder.
* Now run Teuton test:

```
❯ teuton examples/23-test-code

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 100.0 | ✔     |
| 02   | student_2 | 100.0 | ✔     |
+------+-----------+-------+-------+
```
