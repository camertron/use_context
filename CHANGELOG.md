# 1.1.0
* `use_context` now treats all argments after the context name as context keys to extract and yield to the block:
    ```ruby
    use_context(:foo, :bar, :baz) do |bar, baz|
      # ...
    end
    ```
* Documentation updated to describe the new behavior of `use_context` as well as how to use the library as a mixin on a per-class or per-module basis.

# 1.0.0
* Birthday!
