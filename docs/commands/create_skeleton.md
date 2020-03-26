
[<< back](README.md)

# Create skeleton

Create skeleton for a new "foo" project: `teuton create foo`

## Execution

```bash
$ teuton create foo

[INFO] Creating foo project skeleton
* Create dir        => foo
* Create file       => foo/config.yaml
* Create file       => foo/start.rb
* Create file       => foo/.gitignore
```

## Skeleton

This command will create the next structure:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |
| foo/.gitignore  | Prevent uploading YAML files to git repository |
