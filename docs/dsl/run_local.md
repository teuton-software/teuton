[<< back](../README.md)

# Run

* [Local execution](#local-run)
* [Remote execution](#remote-run)

# Local run

Execute command on localhost and save output into result object.

```ruby
run "id COMMAND"
```

## Alias

In fact it's the same as doing next:

```ruby
run "COMMAND", on: :localhost
```

```ruby
run "COMMAND", on: 127.0.0.1
```

```ruby
run "COMMAND", on: 'localhost'
```

## Example

```ruby
run "id david"
```

* This instruction execute "id david" command on local machine, and save results into **result** object.
* Local machine is where the `Teuton` program is running.
