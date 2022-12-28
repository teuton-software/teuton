[<< back](README.md)

# Example: 17-hide-feedback

When exporting with `feedback: false` option we hide some items from exported reports. Hiden items: command, alterations, expected and result.

> More information about [export](../dsl/execution/export.md) keyword.

## Explanation

Every time teuton is run, all cases are evaluated and when exporting the results, by default, all the information collected during the evaluation process is logged.

Each "target" contains the following fields:

* Identification: id, description
* Evaluation result: check(true/false)
* Punctuation: score, weight
* Check process: conn_type, command, duration, alterations, expected, result

Some of these fields should always be visible, such as: id, description, check, score, and weight. And others, more related to the process that perform teuton for verification can be hidden using the "feedback: false" parameter.

With "feedback: false" the fields are hidden: command, alterations, expected and result.
Más información sobre este texto de origen
Para obtener más información sobre la traducción, se necesita el texto de origen
Enviar comentarios
Paneles laterales

## Execution section

Take a look at our test execution section (Play):
```ruby
play do
  show
  export feedback: false
end
```

## Result

Executing `teuton run example/17-hide-feedback`:

```
GROUPS
- Hide feedback from reports
    01 (1.0/1.0)
        Description : Exits user root
        Command     : *******
        Duration    : 0.002 (local)
        Alterations : ******************
        Expected    : ************** (String)
        Result      : * (Integer)
```
