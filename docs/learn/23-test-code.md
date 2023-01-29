[<<back](README.md)

# Test code

Let's test code using teuton.

## Example 1

We ask students to give us a Python program that performs addition and multiplication.


```python
#!/usr/bin/env python3
# File: math_1.py

import sys

num1 = int(sys.argv[1])
num2 = int(sys.argv[2])

print(f'Sum = {num1 + num2}')
print(f'Mul = {num1 * num2}')
```

Output:

```
❯ python3 math_1.py 3 4
Sum = 7
Mul = 12
```

## Defining our targets

```ruby
group "Test code example" do
  folder = "examples/23-test-code/code"

  target "Sum"
  run "./#{folder}/math_1.py 3 4"
  expect /Sum\s+=\s+7/

  target "Mul"
  run "./#{folder}/math_1.py 3 4"
  expect /Mul\s+=\s+12/
end
```
