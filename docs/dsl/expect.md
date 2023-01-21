[<< back](../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Example](#example)
4. [Basic](#basic)
5. [Advanced](#advanced)

## Description

Compare the obtained result with the expected one. This comparation process is registered into final report.

## Usage

```ruby
target 'Exist user obiwan'
run 'cat /etc/passwd'
expect 'root'
```

Use `expect` keyword to check output (from previous execution).

## Example

Let's see some examples:

```ruby
target 'Exist user obiwan'
run 'id obiwan'
expect 'obiwan' # Expect previous command output contains obiwan text
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
| expect_none ["darth", "vader"] | no line with "darth" and "vader" |
| expect /Obiwan\|obi-wan/ | one or more line/s with Obiwan or obi-wan. This example uses regular expresions. |

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
