minitest-stub_any_instance
==========================

Adds a method to MiniTest that stubs any instance of a class.

Installation
------------
Run `gem install minitest-stub_any_instance` from the command prompt

or 

Put `gem "minitest-stub_any_instance"` in your `Gemfile` and run `bundle install` from the command prompt

Usage
------
```ruby
String.stub_any_instance(:length, 42) do
  assert_equal "hello".length, 42
end
```

Credits
---------
Vasiliy Ermolovich (@nashby) gets credit for [writing the code as part of a pull request](https://github.com/seattlerb/minitest/pull/245) to minitest. I extracted it into a gem.

