# frozen_string_literal: true

require "test_helper"

def __weft_provide_context_for_tests(&block)
  provide_context(:test, { key: :top_level_value }, &block)
end

def __weft_use_context_for_tests
  use_context(:test) do |context|
    context[:key]
  end
end

class WeftTest < Minitest::Test
  class Provider
    def self.provide(&block)
      provide_context(:test, { key: :class_value }, &block)
    end

    def provide(&block)
      provide_context(:test, { key: :instance_value }, &block)
    end
  end

  class User
    def self.use
      use_context(:test) do |context|
        context[:key]
      end
    end

    def use
      use_context(:test) do |context|
        context[:key]
      end
    end
  end

  define_method(:provide_context_from_dynamically_defined_method) do |&block|
    provide_context(:test, { key: :value_from_dynamically_defined_method }, &block)
  end

  define_method(:use_context_from_dynamically_defined_method) do
    use_context(:test) do |context|
      context[:key]
    end
  end

  def test_provide_context
    value = provide_context(:test, { key: :inline_value }) do
      use_context(:test) do |context|
        context[:key]
      end
    end

    assert_equal :inline_value, value
  end

  def test_provide_context_from_top_level
    value = __weft_provide_context_for_tests do
      __weft_use_context_for_tests
    end

    assert_equal :top_level_value, value
  end

  def test_provide_context_from_dynamically_defined_method
    value = provide_context_from_dynamically_defined_method do
      use_context_from_dynamically_defined_method
    end

    assert_equal :value_from_dynamically_defined_method, value
  end

  def test_provide_context_from_instance
    assert_equal :instance_value, Provider.new.provide { User.new.use }
  end

  def test_provide_context_from_class
    assert_equal :class_value, Provider.provide { User.use }
  end

  def test_context_can_be_overridden
    provide_context(:test, { setting1: :a, setting2: :a }) do
      use_context(:test) do |context|
        assert_equal :a, context[:setting1]
        assert_equal :a, context[:setting2]

        provide_context(:test, { setting1: :b }) do
          use_context(:test) do |context|
            assert_equal :b, context[:setting1]
            assert_equal :a, context[:setting2]
          end
        end
      end
    end
  end
end
