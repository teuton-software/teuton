[<<back](README.md)

# DSL: expect_sequence

Evaluate the occurrence of a certain sequence that takes place in different lines of the output.

## Description

In the classic target/run/expect, the expect statement works by locating lines from the output of the previous command that meet certain criteria.

We can even (using regular expressions) detect if there is any line in the output where a certain sequence appears.

Example: expect with regular expression to detect the sequence [a, b, c] within a line

```ruby
expect /a.*?b.*?c/
```

Regular expressions are very powerful but they are also complex to use.

To evaluate the occurrence of a certain sequence that takes place in different lines of the output we will use the new "expect_sequence" instruction.

Example: expect_sequence to detect the sequence [a, b, c]

```ruby
expect_sequence do
  find "a"
  find "b"
  find "c"
end
```

> NOTE: expect_sequence can be useful for evaluating iptables firewall configurations where permission assignment order is relevant.
