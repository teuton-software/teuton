
# Creating our first activity

How to create our own challenge, in four steps:

---

## STEP 1: Create skeleton files

You can create the files manually, or run `./teuton create check/foo`.

This command will create:
* `check/foo/start.rb`: Script
* `check/foo/config.yaml`: YAML Config file.
* `check/foo/.gitignore`: To prevent upload YAML and JSON files to Git repository.

> Also, manually, you can create this files.

---

## STEP 2: Personalize your targets

Second, write tests using the key words: `target`, `goto` and `expect`.
Let's see an example:

```
task "task_name" do

	target "Checking user david"
	goto   :host1, :exec => "id david"
	expect result.grep("david").count.equal(1)

end
```

The above example checks if 'david' user exists, on *host1* system.

> Let's see the key words used:
>
> * `target "Checking user <david>"`, Describe the action or the target
with our words, so every one could easily understand what we are trying
to check.
> * `goto :host1, :exec => "id david"`: Execute the command
into the target host.
> * `expect result.grep("david").count.equal(1)`: At the end we need to check the obtained result with our expectations.

---

## STEP 3: Personalize Configfile

We need a YAML configuration file (`check/foo/config.yaml`), with
the params and hosts used by our script.

> Let's see an example:
>
> ```
> ---
> :global:
> :cases:
> - :tt_members: Student1
>   :host1_ip: 1.1.1.1
>   :host1_password: password4student1
> - :tt_members: Student2
>   :host1_ip: 2.2.2.2
>   :host1_password: password4student2
> ```
>
> The above file configures 2 diferents cases with their own params. The script
> use this information when execute every case.

---

## STEP 4: run the script

`/teuton check/foo/start.rb`

_That's all!_
