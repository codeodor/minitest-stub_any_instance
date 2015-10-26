minitest-stub_any_instance
==========================
Adds a method to MiniTest that creates a method stub on any instance of a class for the duration of a block.

Usage
------
```ruby
String.stub_any_instance(:length, 42) do
  assert_equal "hello".length, 42
end
```

Installation
------------
Run `gem install minitest-stub_any_instance` from the command prompt

or 

Put `gem "minitest-stub_any_instance"` in your `Gemfile` and run `bundle install` from the command prompt

Then `require 'minitest/stub_any_instance'` in your `minitest_helper.rb` or test file.

Credits
---------
Vasiliy Ermolovich ([@nashby](https://github.com/nashby/)) gets credit for [writing the code as part of a pull request](https://github.com/seattlerb/minitest/pull/245) to minitest. I extracted it into a gem.

