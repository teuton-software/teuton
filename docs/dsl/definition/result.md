
## Description

`result` saves the output from previous execution.
It is usefull to build advanced `expect result...` sentences.

* After every execution (For example, `goto :host1, :exec => "whoami"`), Teuton gets output and saves it into `result` object.
* Use `result` object to read or filter that output.

## Usage 

This example get /etc/passwd file from host1, then filter lines without '#' and with '/bin/bash'.
Count lines number and expect it to be greater that 6.

```
target "Active users number configured with bash > 6"
goto :host1, :exec => "cat /etc/passwd"
expect result.grep_v('#').grep('/bin/bash').count.gt 6
```

## Examples

Boolean functions:

| Function            | Description               |
| ------------------- | ------------------------- |
| `result.eq(VALUE)`  | Result equal to VALUE     |
| `result.neq(VALUE)` | Result not equal to VALUE |
| `result.gt(VALUE)`  | Result greater than VALUE |
| `result.ge(VALUE)`  | Result equal or greater than VALUE |
| `result.lt(VALUE)`  | Result lesser than VALUE  |
| `result.le(VALUE)`  | Result equal or lesser than VALUE |

Filtering functions:

| Function             | VALUE type  | Description                           |
| -------------------- | ----------- | ------------------------------------- |
| `result.find(VALUE)` | String      | Filter lines that contains VALUE text |
|                      | RegExp      | Filter lines that match VALUE regexp. For example `/?ello]`, filter lines with "Hello" or "hello" |
|                      | Array       | Apply filter to every array element. For example `["Hi","Hello"]`, filter lines with "Hi" or "Hello". |
| `result.grep(VALUE)` |             | Same as find |
| `result.not_find(VALUE)` |         | Filter lines that not contains VALUE. VALUE may be String, Regular Expresion or an Array. |
| `result.grep_v(VALUE)` |           | Same as not_find |
| `result.count`       |             | Count lines from result and save this number into result object. |
| `result.restore`     |             | Restore result data. After every filtering action result is modified, but this function restore data to their original state. |

Information functions:

| Function             | Description |
| -------------------- | --------------------------------- |
| `result.value`       | Return first output line or value |
| `result.content`     | Return all output lines         |
| `result.alterations` | Return transformations applied to the output |
| `result.debug`       | Print the result content on screen. Usefull for debugging process |

## Expert use

It's posible contenate a sequence of several results orders. Examples:

Supose we execute this:
```
goto :host1, :exec => "cat /etc/passwd"
```
And then we could do:
* Get all lines that dosn't contain "nologin" and contain "/bin/bash"
```
result.grep_v("nologin").grep("/bin/bash")
```
* Count all lines that dosn't contain "nologin" and contain "/bin/bash"
```
result.grep_v("nologin").grep("/bin/bash").count
```
* Return true if the number when count all lines that dosn't contain "nologin" and contain "/bin/bash" is greater than 0
```
result.grep_v("nologin").grep("/bin/bash").count.gt 0
```
