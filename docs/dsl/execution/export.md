
## Description

Create reports and save then into `var/CHALLENGE-NAME` folder.

## Usage

```ruby
play do
    export
end
```


## Other

| Command                  | Description |
| ------------------------ | ----------- |
| `export`                 | Export report files using default ouput format |
| `export :format => :txt` | Export file using TXT ouput format |
| `export :format => :colored_text` | Export file using colored TXT ouput format |
| `export :format => :yaml` | Export file using YAML ouput format |
| `export :format => :json` | Export file using JSON ouput format |

## Examples

Run challenge and build reports using default output format:
```
    play do
      export
    end
```

Run challenge and build reports using `colored_text` output format:
```
    play do
      export :format => :colored_text
    end
```
