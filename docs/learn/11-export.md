[<< back](README.md)

# Send

* [export](../dsl/export.md) keyword generate reports into diferents formats:
* [send](../dsl/send.md) keyword send report copies to every remote host.

## Example

```ruby
play do
  show
  export format: :txt
  export format: :html
  send copy_to: :host1
end
```

* `show`, show process log on screen.
* `export format: :txt`, create reports with `txt` format.
* `export format: :html`, create reports with `html` format.
* `send copy_to: :host1`, copy output report into remote machine (host1).
