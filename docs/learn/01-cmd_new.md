
[<< back](README.md)

# new test

Steps:
1. Create skeleton
2. Personalize targets
3. Personalize configuration file
4. Run the challenge

## STEP 1: Create skeleton

Create skeleton for a new project: `teuton create foo`

```
> teuton new foo

[INFO] Creating foo project skeleton
* Create dir        => foo
* Create file       => foo/config.yaml
* Create file       => foo/start.rb
```

> NOTA: It is posible to create these files by hand.

This command will create:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |

---

## STEP 2: Personalize targets

Write your own targets using the keywords: `target`, `run` and `expect`. Let's see:

```ruby
group "Create new test" do
  target "Exist </home/vader> directory"
  run "file /home/vader", on: :host1
  expect_none "No such file or directory"
end
```

The above example checks if exists '/home/david' directory, into *host1* device.

> Let's see the keywords used:
>
> * `target "Exist </home/vader> directory"`, Describe the target with our words, so every one could easily understand what we are trying
to check.
> * `run "file /home/vader", on: :host1`, : Execute the command into the remote machine (host1).
> * `  expect_none "No such file or directory"`: Compare command ouput with our expectations.

## STEP 3: Customize configfile

Use a YAML file (`foo/config.yaml`) or JSON for your own configurations. In this example, the file contains params used by our challenge (script).

**Example**:

```yaml
---
:global:
  :host1_username: root
:cases:
- :tt_members: student-01-name
  :host1_ip: 1.1.1.1
  :host1_password: student-01-password
- :tt_members: student-02-name
  :host1_ip: 2.2.2.2
  :host1_password: student-02-password
```

> The above file configures 2 differents cases with their own params. The script use this information when execute every case.

## STEP 4: run the challenge

Now we only have to run the challenge:

```bash
> teuton run foo
```

Output files are saved into `var/foo` directory.
