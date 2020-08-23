[<< back](README.md)

1. [Execution section](#execution-section)
2. [Result](#result)

# Example: learn-08-preserve

Older output report files are overwritten with new reports, every time we run teuton test. With `preserve` option we keep copies.

> This example is on GitHub repository at `examples/learn-08-preserve/`.

## Execution section

Take a look at our test execution section (Play):
```ruby
play do
  show
  export preserve: true
end
```

> More information about [export](../dsl/execution/export.md) keyword.
## Result

Example, executing `teuton run example/learn-08-preserve` twice:

```
var
└── learn-08-preserve
    ├── 20200519-113035
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── 20200520-113039
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```
