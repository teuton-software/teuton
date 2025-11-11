[<< back](../README.md)

# group

Groups targets.

## Example

```ruby
group "Group name" do
	...
end
```

* Define a group of targets. These are groups of objectives to be evaluated.
* At least you must define one `group`, where you can define all your targets.
* We can use `group`, as many times as we need. Usefull to group related objectives.
