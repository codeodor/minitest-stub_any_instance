require 'minitest/autorun'
require 'stringio'
require File.expand_path("../../lib/minitest/stub_any_instance", __FILE__)

module StubAnyInstanceTest
  class GrandparentClass < BasicObject
    def foo(_a)
      'bar'
    end
  end

  class ParentClass < GrandparentClass
    def foo
      super(:a)
    end
  end

  class ChildClass < ParentClass
  end
end

if Gem.loaded_specs["minitest"].version < Gem::Version.create('5.0')
  MinitestTestClass = MiniTest::Unit::TestCase
else
  MinitestTestClass = Minitest::Test
end


class TestStubAnyInstance < MinitestTestClass
  def setup
    $stderr = StringIO.new
  end

  def test_stubs_a_method_for_the_duration_of_a_block
    got_here = false
    String.stub_any_instance(:length, 42) do
      assert_equal "hello".length, 42
      got_here = true
    end
    assert got_here
  end

  def test_stubs_a_method_without_passing_any_value
    got_here = false
    String.stub_any_instance(:length) do
      assert_nil "hello".length
      got_here = true
    end
    assert got_here
  end

  def test_restores_the_original_method_after_the_block
    string = "hello world"
    got_here = false
    String.stub_any_instance(:length, 42) do
      assert_equal string.length, 42
      got_here = true
    end
    assert_equal string.length, 11
    assert got_here
  end

  def test_does_not_raise_warnings
    got_here = false
    String.stub_any_instance(:length, 42) { got_here = true }
    assert_empty $stderr.string
    assert got_here
  end

  def test_proc_has_access_to_self
    twice_size = -> { self.size * 2 }
    String.stub_any_instance(:length, twice_size) do
      assert_equal 6, 'abc'.length
    end
  end

  def test_stub_method_not_implemented_in_grandchild_class
    ::StubAnyInstanceTest::ChildClass.stub_any_instance(:foo, :result) do
      assert_equal :result, ::StubAnyInstanceTest::ChildClass.new.foo
    end
  end

  def test_stubbed_method_does_not_get_restored_to_non_owning_class
    assert_equal 'bar', ::StubAnyInstanceTest::ChildClass.new.foo
  end

  def test_stubbing_method_with_arguments
    original_string = "do not change me"
    changed_string = "i changed"
    gsubbed = original_string.gsub(original_string, changed_string)
    assert_equal gsubbed, changed_string

    String.stub_any_instance(:gsub, original_string) do
      gsubbed = original_string.gsub(original_string, changed_string)
      assert_equal gsubbed, original_string
      assert gsubbed != changed_string
    end
  end

  def test_stubbing_method_with_keyword_arguments
    original_string = "do not change me"
    assert_equal original_string.length, 16

    use_return_arg = ->(return_arg: 0) { return_arg }
    String.stub_any_instance(:length, use_return_arg) do
      result = original_string.length(return_arg: :foo)
      assert_equal result, :foo
    end
  end

end
