[<< back](../README.md)

## Description

Execute command on localhost and save output into result object.

## Usage

```ruby
run "id COMMAND"
```

**Alias**: In fact it's the same as doing next:
```
run "COMMAND", on: :localhost
run "COMMAND", :on => :localhost
on :localhost, run: "COMMAND"
on :localhost, :run => "COMMAND"
goto :localhost, execute: "COMMAND"
goto :localhost, :execute => "COMMAND"
```

> Then, why have another instruction? Because there are people who like doing that way.

## Example

```ruby
run "id david"
```

* This instruction execute "id david" command on local machine, and save results into **result** object.
* Local machine is where the `Teuton` program is running.
