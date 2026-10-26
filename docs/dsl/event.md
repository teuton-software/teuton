[<< back](../README.md)

# event

Sometimes it may be necessary to trigger an action when a specific condition occurs; for this, we can use events.

Events are defined using the following structure:

```ruby
event on: OBJECT, when: CONDITION do
  ACTION
end
```

Where
* OBJECT can be `:last_target`
* CONDITION can be `:failed`
* And ACTION can be `stop`, `scores_to_zero`, or both.

## Example

```ruby
  event on: :last_target, when: :failed do
    stop
  end
```

An event is defined to trigger the `stop` action when the last target fails.

The "stop" action halts the test, setting the number of targets yet to be evaluated to zero, while the rest retain their current assessment.


# Events

Events are used to define actions that are triggered only when specific conditions are met.

Syntax:

```ruby
event on: OBJECT, when: CONDITION do ACTIONS end
```

Events consist of three parts:

* `on: OBJECT` - defines the object for which the event is being set. 
* `when: CONDITION` - defines the condition that must be met by the OBJECT to trigger the action(s). 
* `do ACTIONS end` – defines the action(s) to be executed when the event is triggered.

In the initial version, the following are available:

| Type      | Element        | Description                             | Status |
| --------- | -------------- | --------------------------------------- | ------ |
| OBJECT    | last_target    | Applies to the last evaluated target    |        |
| OBJECT    | every_target   | Applies to each individual target       | TODO   |
| OBJECT    | all_targets    | Applies to all targets collectively     | TODO   |
| CONDITION | failed         | The object's state is "failed"          |        |
| CONDITION | is_ok          | The object's state is "correct" (OK)    | TODO   |
| ACTION    | scores_to_zero | Resets all points earned so far to zero |        |
| ACTION    | stop           | Stops the test for this case            |        |
| ACTION    | log            | Records a message in the log            | TODO   |

## Example 1: "stop" action

Example:

```ruby
group "Target with an exit condition" do
  target "User 'root' exists"
  run "id root"
  expect_ok

  target "User 'vader' exists", when_fails: :stop
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed, do
    stop
  end

  target "User 'mail' exists"
  run "id mail"
  expect_ok
end
```

The test is executed as follows:

* target 1: Evaluated and scored. 
* target 2: Evaluated and scored. 
* event:
    * on: :last_target – based on the result of the last target:
    * when: :failed
        * If the result is a failure, the test ends here (for this case).
        * If the result is successful, the process continues normally with target 3.
* Upon completion:
    * The remaining "targets" are left unevaluated. 
    * The final score is derived from both the evaluated and unevaluated targets.

## Example 2: "grades_to_zero" action

Example:

```ruby
group "Target with an exit condition" do
  target "User 'root' exists"
  run "id root"
  expect_ok

  target "User 'vader' exists"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed, do
    scores_to_zero
  end

  target "User 'mail' exists"
  run "id mail"
  expect_ok
end
```

This test is executed as follows:

* target 1: Executed and evaluated. 
* target 2: Executed and evaluated. 
* event:
    * on: :last_target — based on the result of the last target:
    * when: :failed
        * If the result is a failure, all "targets" evaluated up to that point are set to zero. 
        * If the result is successful, the process continues normally. 
* Upon completion:
    * The remaining unevaluated "targets" are processed. 
    * The final score is derived from both the evaluated and unevaluated targets.

## Example 3: Combining two actions

Example:

```ruby
group "Target with an exit condition" do
  target "User 'root' exists"
  run "id root"
  expect_ok

  target "User 'vader' exists"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed, do
    log "Test stopped due to failure of target 2"
    scores_to_zero
    stop
  end

  target "User 'mail' exists"
  run "id mail"
  expect_ok
end
```

This test is executed as follows:

* target 1: Executed and evaluated. Target 2: Executed and evaluated. 
* event
    * on: :last_target — based on the outcome of the last target, the following actions are taken:
    * when: :failed
        * If the result is a failure:
            * A message is recorded in the report log. 
            * All targets evaluated up to this point are reset to zero,
            * and the test is terminated. 
            * In this case, the final score will be zero. 
        * If the result is successful, the process continues as normal.
