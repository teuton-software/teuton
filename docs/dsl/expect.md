[<< back](../README.md)

# expect

Compare the obtained result with the expected one. This comparation process is registered into final report.

## Example

Let's see some examples:

```ruby
target 'Exist user obiwan'
run 'id obiwan'
expect 'obiwan' # Expect previous run command output contains obiwan text
```

## Basic

| Command | Description |
| ------- | ----------- |
| expect "yoda" or expect_any "yoda" | one or more line/s with "yoda" |
| expect ["obiwan", "kenobi"] | one or more line/s with "obiwan" and kenobi" |
| expect_first "episode" | the first line with "episode" |
| expect_last "episode" | the last line with "episode" |
| expect_one "rogue" | only one line with "rogue" |
| expect_one ["obiwan","kenobi"] | only one line with "obiwan" and "kenobi" |
| expect_none "vader"| no line with "vader" |
| expect_none ["darth", "vader"] | no line with "darth" or "vader" |
| expect_none | no output lines expected |
| expect_nothing | no output lines expected |
| expect /Obiwan\|obi-wan/ | one or more line/s with Obiwan or obi-wan. This example uses regular expresions. |
| expect_exit NUMBER | Check exit code is NUMBER |

## Advanced

After every execution keyword (`run`, `on` or `goto`), command outputs is saved by **result** object. Use **result** to create more complex evaluations.

For example, if we have this execution

```ruby
target 'Exist user vader'
run    'cat /etc/passwd'
```

Then we check result with:

* **expect result.find("vader").count.eq(1)**, expect there exists only 1 line with "vader" text.
* **expect result.find(/Darth|darth/).find(/Vader|vader/).count.gt(2)**, expect there exists more than 2 lines with texts "Darth" and "Vader".
* **expect result.not_find('#').find('vader').count.lt(3)**, expects there exists less than 3 lines with text "vader" and without "#" symbol.

Read [result](result.md) documentation.
