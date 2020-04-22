[<< back](../../README.md)

## Description

Create reports and save then into `var/TEST-NAME` folder.

## Usage

```ruby
play do
    export
end
```

## Formats

| Command                  | Description |
| ------------------------ | ----------- |
| `export`                 | Export report files using default ouput format |
| `export :format => :txt` | Export file using TXT ouput format |
| `export :format => :html` | Export file using HTML ouput format |
| `export :format => :yaml` | Export file using YAML ouput format |
| `export :format => :json` | Export file using JSON ouput format |
| `export :format => :colored_text` | Export file using colored TXT ouput format |

## Example

Run export and build reports using txt output format by default:
```
    play do
      export
    end
```

Run test and build reports using `html` output format:
```
    play do
      export :format => :html
    end
```
