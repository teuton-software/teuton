[<< back](README.md)

# Send

* [export](../dsl/export.md) keyword generate reports into diferents formats:
* [send](../dsl/send.md) keyword send report copies to every remote host.

## Example

```ruby
play do
  show
  export
  send copy_to: :host1
end
```

* `show`, show process log on screen.
* `export`, create reports with `txt` format.
* `send copy_to: :host1`, copy output report into remote machine (host1).
