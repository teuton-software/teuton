
# Create skeleton

Create skeleton for a new "foo" project: `teuton create foo`

## Execution

```bash
$ teuton create foo

[INFO] Create project <foo>
* Create dir        => foo
* Create dir        => foo/assets
* Create file       => foo/start.rb
* Create file       => foo/config.yaml
* Create file       => foo/.gitignore
* Create file       => foo/README.md
```

## Skeleton

This command will create:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/assets      | Base directory for other resources (images and text files) |
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |
| foo/.gitignore  | Prevent uploading YAML files to git repository |
| foo/README.md   | Statement of our practice |
