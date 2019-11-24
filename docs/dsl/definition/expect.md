
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

## Other uses

| Command                      | Description                         |
| ---------------------------- | ----------------------------------- |
| expect 'obiwan'              | Expect line/s with obiwan |
| expect ['obiwan', 'kenobi' ] | Expect line/s with obiwan and kenobi|
| expect_one 'obiwan'          | Expect one line with obiwan |
| expect_one ['obiwan','kenobi'] | Expect one line with obiwan and kenobi |
| expect_none 'obiwan'         | Expect no line with obiwan       |
| expect_none ['obiwan', 'kenobi' ] | Expect no line with obiwan and kenobi |

* **expect /Obiwan|obi-wan/**, Expect line/s with Obiwan or obi-wan. This example uses regular expresions.

---

## Expert mode

After every execution keyword (`goto`, or `run`), we get command outputs and save it into `result` object. So we can ask to `result` to create more complex evaluations.

For example, if we have this execution
```ruby
target 'Exist user vader'
run 'cat /etc/passwd'
```

Then we check result with
```ruby
expect result.find("vader").count.eq(1)
expect result.find(/Darth|darth/).find(/Vader|vader/).count.eq(1)
expect result.not_find('#').find(/vader).count.eq(1)
```
