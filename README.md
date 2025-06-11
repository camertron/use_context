## use_context

![Unit Tests](https://github.com/camertron/use_context/actions/workflows/unit_tests.yml/badge.svg?branch=main)

## What is this thing?

use_context is a tool for providing block-level context to Ruby programs in a thread-safe and fiber-safe way. Internally it leverages fiber-local storage. It can be used to provide data, etc to parts of your program that might be difficult or inconvenient to reach with eg. normal argument passing.

use_context was inspired by this use-case, and originally proposed as an addition to ViewComponent: https://github.com/ViewComponent/view_component/discussions/2327

## Usage

There are three ways to use this gem. As some folks are understandably uncomfortable using monkeypatches - especially ones applied to core classes and modules - you are free to choose the one that fits your preferences.

### As a monkeypatch

Add the following to your program or application somewhere:

```ruby
require "use_context/ext/kernel"
```

This will add two methods to `Kernel` so they are available everywhere: `provide_context`, and `use_context`. Contexts consist of a name and a hash of key/value pairs.

```ruby
def speak
  use_context(:welcome) do |context|
    puts context[:salutation]
  end
end

provide_context(:welcome, { salutation: "Hello, world!" }) do
  speak  # prints "Hello, world!"
end
```

Values are available in the current context only for the duration of the block passed to `provide_context`, and reset after the block returns.

### As a refinement

Add the following to your program or application somewhere:

```ruby
require "use_context/ext/kernel_refinement"
```

The refinement can be enabled at the class, module, or file level, and adds the same two methods to `Kernel`. Refinements work differently than monkeypatching in that their changes are not globally applied and are only visible within the scope they are enabled in.

```ruby
# Makes provide_context and use_context available on Kernel, but only within this file
using UseContext::KernelRefinement

provide_context(:welcome, { salutation: "Hello, world!" }) do
  ...
end
```

### No magic

If you'd rather avoid modifying `Kernel` altogether, use_context can also be used via the `UseContext` constant.

Add the following to your program or application somewhere:

```ruby
require "use_context"
```

Then simply call `UseContext.provide_context` and `UseContext.use_context`:

```ruby
UseContext.provide_context(:welcome, { salutation: "Hello, world!" }) do
  WUseContexteft.use_context(:welcome) do |context|
    puts context[:salutation]  # prints "Hello, world!"
  end
end
```

## Overriding context

If a key already exists in the current context, it will be overridden, but only for the duration of the block:

```ruby
provide_context(:welcome, { salutation: "Hello, world!" }) do
  provide_context(:welcome, { salutation: "Hola, mundo!" }) do
    speak  # prints "Hola, mundo!"
  end

  speak  # prints "Hello, world!"
end
```

## Running Tests

`bundle exec rake` should do the trick.

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
