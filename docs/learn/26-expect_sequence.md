[<<back](README.md)

# DSL: expect_sequence

Evaluate the occurrence of a certain sequence that takes place in different lines of the output.

> Example files at [examples/26-expect_sequence](../../examples/26-expect_sequence)

## Description

In the classic target/run/expect, the expect statement works by locating lines from the output of the previous command that meet certain criteria.

We can even (using regular expressions) detect if there is any line in the output where a certain sequence appears.


```ruby
# Example:
#   expect with regular expression to detect [a, b, c] sequence
#   within a line

expect /a.*?b.*?c/
```

> Regular expressions are very powerful but they are also complex to use.

To evaluate the occurrence of a certain sequence that takes place in different lines of the output we will use the new "expect_sequence" instruction.


```ruby
# Example:
#   expect_sequence to detect [a, b, c] sequence

expect_sequence do
  find "a"
  find "b"
  find "c"
end
```

> NOTE: expect_sequence can be useful for evaluating iptables firewall configurations where permission assignment order is relevant.

## Evaluating different sequences

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
