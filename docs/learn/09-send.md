[<< back](README.md)

# Send

`send` is a keyword used to copy the output report into remote host.

## Example

```ruby
play do
  show
  export
  send copy_to: :host1
end
```

* `show`, show process log on screen.
* [export](../dsl/export.md), create reports with `txt` format.
* [send copy_to: :host1](../dsl/send.md), copy output report into remote machine (host1).
* `host1`, is a set params defined into config file (host1_ip, host1_username, host1_password, etc.)