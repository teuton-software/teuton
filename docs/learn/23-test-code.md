[<<back](README.md)

# Test code

Let's test code using teuton.

## Exercise

Ask students to make a program that performs addition and multiplication.

Usage:
```
$ examples/23-test-code/code/math_1.py 3 4
Sum = 7
Mul = 12
```

## Example

Define targets `sum` and `mul`:

```ruby
# File: start.rb
group "Test code example" do
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

Define config params:

```yaml
# File: config.yaml
---
global:
  folder: examples/23-test-code/code
cases:
- tt_members: student_1
  sum_filename: 01/sum.py
  mul_filename: 01/mul.py
- tt_members: student_2
  sum_filename: 02/sum.py
  mul_filename: 02/mul.py
```

* Copy students files into `code` subfolder.
* Now run Teuton test:

```
$ teuton examples/23-test-code

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 100.0 | ✔     |
| 02   | student_2 | 100.0 | ✔     |
+------+-----------+-------+-------+
```
