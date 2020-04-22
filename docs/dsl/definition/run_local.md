[<< back](../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Alias](#alias)
4. [Example](#example)

## Description

Execute command on localhost and save output into result object.

## Usage

```ruby
run "id COMMAND"
```

## Alias

In fact it's the same as doing next:

```ruby
run "COMMAND", on: :localhost
run "COMMAND", :on => :localhost
on :localhost, run: "COMMAND"
on :localhost, :run => "COMMAND"
goto :localhost, execute: "COMMAND"
goto :localhost, :execute => "COMMAND"
```

> why have another instruction? Because there are people who like do it differently.

## Example

```ruby
run "id david"
```

* This instruction execute "id david" command on local machine, and save results into **result** object.
* Local machine is where the `Teuton` program is running.
