[<< back](../../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Example](#example)
4. [Formats](#formats)

## Description

Create reports and save then into `var/TEST-NAME` folder.

## Usage

```ruby
play do
    export
end
```

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
  export :format => :html
end
```


## Formats

|    | Command                  | Description |
| -- | ------------------------ | ----------- |
| 01 | `export`                 | Export report files using default ouput format |
| 02 | `export :format => :txt` | Export file using TXT ouput format |
| 03 | `export :format => :html` | Export file using HTML ouput format |
| 04 | `export :format => :yaml` | Export file using YAML ouput format |
| 05 | `export :format => :json` | Export file using JSON ouput format |
| 06 | `export :format => :colored_text` | Export file using colored TXT ouput format |
| 07 | `export :preserve => true` | Same as 01 example buy preserving report copies |
| 08 | `export :format => :html, :preserve => true` | Same as 03 example but preserving report copies |
| 09 | `export format: :html, preserve: true` | Same as 08 example |
