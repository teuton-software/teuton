[<< back](README.md)

# Target weight

`weight` is param used by `target` keyword to define weight target value.

## Example

Changing default target weight:
* The first target has the default weight (1.0).
* The second target has a weight of 2.0.

```ruby
# File: network.rb

group "Using file: network" do
  target "Update computer name with #{get(:hostname)}"
  run "hostname", on: :host1
  expect_one get(:hostname)

  target "Ensure DNS Server is working", weight: 2.0
  run "host www.google.es", on: :host1
  expect "www.google.es has address "
end
```

Output:
```
+----------------------------+
| GROUP: Using file: network |
+----------------------------+
(002) target      Update computer name with get(hostname)
      weight      1.0
      run         'hostname' on host1
      expect_one  get(hostname) (String)

(003) target      Ensure DNS Server is working
      weight      2.0
      run         'host www.google.es' on host1
      expect      www.google.es has address  (String)
```
