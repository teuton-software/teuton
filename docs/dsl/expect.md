[<< back](../README.md)

# expect

Compare the obtained result with the expected one. This comparation process is registered into final report.

## Example

Let's see some examples:

```ruby
target "Exist user obiwan"
run "id obiwan"
expect "obiwan" # Expect run command output will contain "obiwan"
```

## Simple evaluations

| Command                       | Description                    |
| ----------------------------- | ------------------------------ |
| expect "yoda"                 | one or more line/s with "yoda" |
| expect_any "yoda"             | one or more line/s with "yoda" |
| expect ["obiwan", "kenobi"]   | one or more line/s with "obiwan" and kenobi" |
| expect_first "episode"         | the first line with "episode" |
| expect_last "the end"          | the last line with "the end" |
| expect_one "rogue"             | only one line with "rogue" |
| expect_one ["obiwan","kenobi"] | only one line with "obiwan" and "kenobi" |
| expect /Obiwan\|obi-wan/       | one or more line/s with Obiwan or obi-wan. This example uses regular expresions. |

## Negative evaluations

| Command                        | Description                  |
| ------------------------------ | ---------------------------- |
| expect_none "vader"            | Expects no line with "vader" |
| expect_none ["darth", "vader"] | no line with "darth" or "vader" |
| expect_none                    | no output lines expected |
| expect_nothing                 | no output lines expected |

## Exitcode evaluations

| Command              | Description               |
| -------------------- | ------------------------- |
| expect_ok            | Check exit code is 0      |
| expect_fail          | Check exit code is > 0    |
| expect_exit NUMBER   | Check exit code is NUMBER |
| expect_exit MIN..MAX | Check exit code is >= MIN and < MAXNUMBER |

## Evaluate sequence

* **Simple sequence**. Validate sequences where the elements are in order. Use `find` statement to find each element of the sequence.

```ruby
# Examples: [A,B,C], [A,s,B,s,C], [x,A,B,s,C,x], etc.

expect_sequence do
  find "A"
  find "B"
  find "C"
end
```

* **Strict sequence**. validate sequences where the elements are in strict consecutive order. First use `find` to find an element in the sequence and then `next_to` for the next element in strict order.

```ruby
# Examples: [A,B,C], [x,A,B,C,x], etc.

expect_sequence do
  find "A"
  next_to "B"
  next_to "C"
end
```

* **Strict sequence with jumps**. Use `ignore N` to indicate that there are N lines between 2 elements of the sequence.

```ruby
# Examples: [A,B,s,s,C], [x,A,B,s,s,C,x], etc.

expect_sequence do
  find "A"
  next_to "B"
  ignore 2
  next_to "C"
end
```

## Complex evaluations

After every execution keyword `run`, command outputs is wrapped into **result** object. We may use **result** to make complex evaluations.

For example, if we have this execution

```ruby
target 'Exist user vader'
run    'cat /etc/passwd'
```

Then we can check result with:

* **expect result.find(/obiwan|kenobi/).count.eq(1)**, expect there exists only 1 line with "obiwan" or "kenobi".
* **expect result.find(/darth/).find(/vader/).count.gt(2)**, expect there exists more than 2 lines with texts "darth" and "vader".
* **expect result.not_find('#').find('yoda').count.lt(3)**, expects there exists less than 3 lines with text "yoda" and without "#" symbol.

Read more about [result](result.md) object.
