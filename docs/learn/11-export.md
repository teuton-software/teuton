[<< back](README.md)

# Export

[export](../dsl/export.md) keyword generates output reports into diferents formats.

Available formats: colored_text, html, json, markdown, txt, xml, yaml.

## Example

```ruby
play do
  show
  export format: :txt
  export format: :html
  export format: :json
end
```

* `show`, show process on screen.
* `export format: :txt`, create reports with `txt` format.
* `export format: :html`, create reports with `html` format.
* `export format: :json`, create reports with `json` format.

Firs run `teuton examples/11-export`, then we have this files:

```
$ tree var/11-export

var/11-export
├── case-01.html
├── case-01.json
├── case-01.txt
├── moodle.csv
├── resume.html
├── resume.json
└── resume.txt
```
