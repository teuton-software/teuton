
## Description

Execute command on localhost and save output into result object.

**Alias**: In fact it's the same as doing `goto :localhost, :execute => "COMMAND"`.

> Then, why have another instruction? Because there are people who like doing this way.

## Usage

```ruby
run "id david"
```

## Example

```ruby
run "id david"
```

* This instruction execute "id david" command on local machine, and save results into `result` object.
* Local machine is where the `Teuton` program is running.
