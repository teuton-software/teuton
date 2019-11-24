
## Description

DSL keyword that starts the execution of all targets/goals (defined into groups). We put this instruction at the end of every script, so it begin running the tests over the machines.

## Usage

```ruby
play do
	...
end
```

* Write this block at the end of the rb script, to indicate that it's the moment to start the evaluation process.
* The `group/target` instructions defines the tests we want to do, but `play` instruction is used to begin execution of all the groups/targets into every remote hosts of every case.
* If you don't write this instruccion, your tests will never be executed.
