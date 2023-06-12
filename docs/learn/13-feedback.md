[<< back](README.md)

# Feedback

Exporting with false feedback option `export feedback: false`, hide some items from output reports. Hiden items: command, alterations, expected and result.

> More information about [export](../dsl/execution/export.md) keyword.

Example

```ruby
play do
  show
  export feedback: false
  export format: "html", feedback: false
end
```

## Description

Every time teuton is run, all cases are evaluated and when exporting the results, by default, all the information collected during the evaluation process is logged.

Each `target` contains following fields:

* Identification: `id`, `description`
* Evaluation result: `check`(true/false)
* Punctuation: `score`, `weight`
* Check process: `conn_type`, `command`, `duration`, `alterations`, `expected` and `result`

Some of these fields should always be visible, such as: id, description, check, score, and weight. And others, more related to the process that perform teuton for verification can be hidden using the `feedback: false` parameter.

With `feedback: false` the fields are hidden: command, alterations, expected and result.

## Results

Executing `teuton run examples/13-feedback`, we get this output:

```
GROUPS
- Preserve output reports
    01 (1.0/1.0)
        Description : Exits user Obiwan
        Command     : ********
        Duration    : 0.002 (local)
        Alterations : *******************
        Expected    : ************** (String)
        Result      : ******** (String)
```
