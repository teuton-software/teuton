[<< back](../README.md)

# result

**result** object saves the output from previous execution.
It is usefull to build advanced `expect result...` sentences.

After every execution (For example, `run "whoami", on: :host1`), Teuton gets output and saves it into **result** object. Then use **result** object to read or filter previous command output.

## Example 1

This example:
1. get `/etc/passwd` file from `host1`, then
2. filter lines without `#` and with `/bin/bash`.
3. count lines number and
4. expect it to be greater that 6.

Let's see:

```
target "Active users with bash > 6"
run   "cat /etc/passwd", on: :host1
expect result.grep_v('#').grep('/bin/bash').count.gt 6
```

## Example 2

It's posible contenate a sequence of several results orders. Examples:

Supose we execute this:
```
run "cat /etc/passwd", on: :host1
```

And then we could do:

| Description | Command |
| ----------- | ------- |
| Get all lines that dosn't contain "nologin" and contain "/bin/bash" | result.grep_v("nologin").grep("/bin/bash") |
| Count all lines that dosn't contain "nologin" and contain "/bin/bash" | result.grep_v("nologin").grep("/bin/bash").count |
| Return true if the number when count all lines that dosn't contain "nologin" and contain "/bin/bash" is greater than 0 | result.grep_v("nologin").grep("/bin/bash").count.gt 0 |

## Functions

**Boolean functions:**

| Function            | Description               |
| ------------------- | ------------------------- |
| result.eq(VALUE)  | Result equal to VALUE     |
| result.neq(VALUE) | Result not equal to VALUE |
| result.gt(VALUE)  | Result greater than VALUE |
| result.ge(VALUE)  | Result equal or greater than VALUE |
| result.lt(VALUE)  | Result lesser than VALUE  |
| result.le(VALUE)  | Result equal or lesser than VALUE |

**Filtering functions:**

| Function             | VALUE type  | Description                           |
| -------------------- | ----------- | ------------------------------------- |
| result.count       |             | Count lines from result and save this number into result object. |
| result.first | | Remove all lines except first one.|
| result.find(VALUE) | String      | Filter lines that contains VALUE text |
|                      | RegExp      | Filter lines that match VALUE regexp. For example `/?ello]`, filter lines with "Hello" or "hello" |
|                      | Array       | Apply filter to every array element. For example `["Hi","Hello"]`, filter lines with "Hi" or "Hello". |
| result.grep(VALUE) | String, RegExp, Array | Same as find |
| result.grep_v(VALUE) | String, RegExp, Array | Same as not_find |
| result.last | | Remove all lines except last one.|
| result.not_find(VALUE) |         | Filter lines that not contains VALUE. VALUE may be String, Regular Expresion or an Array. |
| result.restore     |             | Restore result data. After every filtering action result is modified, but this function restore data to their original state. |

**Information functions:**

| Function             | Description |
| -------------------- | --------------------------------- |
| result.alterations | Return transformations applied to the output |
| result.content     | Return all output lines         |
| result.debug       | Print the result content on screen. Usefull for debugging process |
| result.value       | Return first output line or value |
