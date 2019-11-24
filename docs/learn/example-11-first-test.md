
Steps:
1. Create skeleton
2. Personalize targets
3. Personalize configuration file
4. Run the challenge

---

## STEP 1: Create skeleton

Create skeleton for a new project: `teuton create foo`

```bash
$ teuton create foo

[INFO] Create project <foo>
* Create dir        => foo
* Create dir        => foo/assets
* Create file       => foo/start.rb
* Create file       => foo/config.yaml
* Create file       => foo/.gitignore
* Create file       => foo/assets/README.md
```

> It's posible to create these files by hand.

This command will create:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/assets      | Base directory for assest (images and text files) |
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |
| foo/.gitignore  | Prevent uploading YAML files to git repository |
| foo/assets/README.md | Statement of practice |

---

## STEP 2: Personalize targets

Write your own targets using the keywords: `target`, `goto` and `expect`. Let's see an example:

```ruby
group "Demo group" do

	target "Exist </home/david> directory"
	goto   :host1, :exec => "file /home/david"
	expect ["/home/david", "directory"]

end
```

The above example checks if exists 'yoda' user, on *host1* system.

> Let's see the keywords used:
>
> * `target "Exist </home/david> directory"`, Describe the target with our words, so every one could easily understand what we are trying
to check.
> * `goto :host1, :exec => "file /home/david"`: Execute the command
into the remote machine (host1).
> * `expect ["/home/david", "directory"]`: Compare command ouput with our expectations.

---

## STEP 3: Personalize Configfile

Use a YAML file (`foo/config.yaml`) or JSON for your own configurations. In this example, the file contains params used by our challenge (script).

**Example**:

```yaml
---
:global:
 :host1_username: root
:cases:
- :tt_members: Student 01 name or alias
 	:host1_ip: 1.1.1.1
 	:host1_password: root-password-student-01
- :tt_members: Student 02 name or alias
 	:host1_ip: 2.2.2.2
 	:host1_password: root-password-student-02
```

> The above file configures 2 diferents cases with their own params. The script use this information when execute every case.

---

## STEP 4: run the challenge

Now we only have to run the challenge:

```bash
$ teuton foo
```
