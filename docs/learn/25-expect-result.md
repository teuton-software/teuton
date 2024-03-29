[<<back](README.md)

# expect vs result

* `expect` is the statement we use to evaluate the result generated by a previous `run` statement.
* `result` allows you to manipulate the output of the run command in more detail.

`expect` is easier to use but less powerful than `result`.

> Example files at [examples/25-expect-result](../../examples/25-expect-result)

## Expect

`expect` has different ways to evaluate result.

| DSL                | Description |
| ------------------ | ----------- |
| expect FILTER      | it finds lines in the output with the content FILTER |
| expect_none FILTER | it finds lines in the output without the FILTER content |
| expect_nothing     | is true when the result is empty |
| expect_exit NUMBER | Exit code is NUMBER |
| expect_ok          | Exit code 0 |
| expect_fail        | Exit code > 0 |

> Learn more about [expect](../dsl/expect.md)

## Result

`result` is an object that encapsulates the output of the run command and allows manipulation of its contents before being evaluated by `expect`.

| Result command | Description |
| -------------- | ----------- |
| expect result.count.eq NUMBER | Is true when output has NUMBER lines |
| expect result.count.gt NUMBER | Is true when output has more than NUMBER lines |
| expect result.count.lt NUMBER | is true when output has less than NUMBER lines |
| expect result.grep(FILTER).count.eq NUMBER | output has NUMBER lines with FILTER |
| expect result.grep_v(FILTER).count.eq NUMBER | output has NUMBER lines without FILTER |

> Learn more about [result](../dsl/result.md)
