[<< back](../../README.md)

# export

Create output reports into `var/TESTNAME` folder.

**Example 1**: Run export and build reports using default format (`txt`).
```ruby
play do
  export
end
```

**Example 2**: Run test and build reports using `html` format.
```ruby
play do
  export format: 'html'
end
```

## Options

| Option | Values | Description |
| ------ | ------ | ----------- |
| format | **txt** (default), html, yaml, json, markdown, colored_text (txt with colors) |Output file format |
| preserve | **false** (default), true | Keep old report copies |
| feedback | **true** (default), false | Hide feedback information from reports |

## Usage

|    | Command                  | Description |
| -- | ------------------------ | ----------- |
| 01 | `export`                 | Export report files using default ouput format |
| 02 | `export format: 'txt'` or  `export format: :txt` | Export file using TXT ouput format |
| 03 | `export format: 'html'` or `export format: :html`  | Export file using HTML ouput format |
| 04 | `export format: 'yaml'` or `export format: :yaml`| Export file using YAML ouput format |
| 05 | `export format: 'json'` or `export format: :json`| Export file using JSON ouput format |
| 06 | `export format: 'colored_text'` or  `export format: :colored_text` | Export file using colored TXT ouput format |
| 07 | `export preserve: true` | Export default format and preserve report copies |
| 08 | `export format: 'html', preserve: true` or `export format: :html, preserve: true` | Export 'html' format and preserve report copies |
| 09 | `export feedback: false` | With "feedback: false" some fields are hidden: command, alterations, expected and result |
