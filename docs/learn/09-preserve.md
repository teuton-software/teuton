[<< back](README.md)

# Example: 09-preserve

Every time we run teuton test, older output report files are overwritten with new reports. if you want to preserve old versions then use `preserve`.

With `preserve` option we keep older copies.

1. [Execution section](#execution-section)
2. [Result](#result)

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

Example, executing `teuton run example/learn-09-preserve` twice:

```
var
└── learn-09-preserve
    ├── 20200519-113035
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── 20200519-123039
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

* The first time test was launched at 11:30, and second at 12:30 the same day.
