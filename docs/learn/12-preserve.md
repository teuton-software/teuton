[<<back](../../README.md)

# preserve

`preserve` is an option of `export` keyword used to keep older report copies.

Every time we run teuton test, older output report files are overwritten with new reports. if you want to preserve old versions then use `preserve`.

Usage: `export preserve: true`

## Example

Example files in the `examples/12-preserve` folder.

**Execution section**

Take a look at our test execution section (Play):
```ruby
play do
  show
  export preserve: true
end
```

> More information about [export](../dsl/export.md) keyword.

**Result**

Example, executing `teuton run example/12-preserve` twice:

```
var
└── 12-preserve
    ├── 20200519-163035
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── 20200519-173039
    │   ├── case-01.txt
    │   ├── moodle.csv
    │   └── resume.txt
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

The first time test was launched at 16:30, and second at 17:30 the same day.
