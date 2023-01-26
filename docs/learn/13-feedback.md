[<< back](README.md)

# Feedback

* [export feedback: false](../dsl/export.md) will hide feedback information on output reports.

Example
```ruby
play do
  show
  export feedback: false
  export format: "html", feedback: false
end
```

* Run `teuton examples/13-feedback`.
* Then `more examples/13-feedback/case-01.txt`.

```
GROUPS
- Preserve output reports
    01 (1.0/1.0)
        Description : Exits user david
        Command     : ********
        Duration    : 0.002 (local)
        Alterations : *******************
        Expected    : ************** (String)
        Result      : ******** (String)
```
