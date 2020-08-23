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

* **expect 'obiwan'**, expect line/s with "obiwan".
* **expect ['obiwan', 'kenobi'**, expect line/s with "obiwan" and kenobi".
* **expect_one 'obiwan'**, expect only one line with "obiwan".
* **expect_one ['obiwan','kenobi']**, expect only one line with "obiwan" and "kenobi".
* **expect_none 'obiwan'**, expect no line with "obiwan".
* **expect_none ['obiwan', 'kenobi']**, expect no line with "obiwan" and "kenobi".
* **expect /Obiwan|obi-wan/**, Expect line/s with Obiwan or obi-wan. This example uses regular expresions.

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
