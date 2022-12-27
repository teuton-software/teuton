[<< back](../../README.md)

1. [Description](#description)
2. [Example](#example)
3. [Options](#options)
4. [Usage](#usage)

## Description

Create reports and save then into `var/TEST-NAME` folder.

## Example

Run export and build reports using txt output format by default:

```ruby
play do
  export
end
```

Run test and build reports using `html` output format:

```ruby
play do
  export format: 'html'
end
```

## Options

1. **format**: txt, html, yaml, json, colored_text (txt with colors).
2. **preserve**: true, false.

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
