# frozen_string_literal: true

require "singleton"

module UseContext
  Fiber.attr_accessor :uc_context

  class << self
    def current
      Fiber.current
    end

    def context
      current.uc_context ||= {}
    end
  end

  class EmptyContext
    include Singleton

    def [](_key)
      nil
    end

    def empty?
      true
    end

    def present?
      false
    end
  end

  class Context
    def initialize(stack)
      @stack = stack
    end

    def [](key)
      @stack.reverse_each do |context_hash|
        if context_hash.include?(key)
          return context_hash[key]
        end
      end

      nil
    end

    def empty?
      false
    end

    def present?
      true
    end
  end

  class ContextStack
    attr_reader :context

    def initialize
      @stack = []
      @context = Context.new(@stack)
    end

    def push(context_hash)
      @stack << context_hash
    end

    def pop
      @stack.pop
    end
  end

  module ContextMethods
    def provide_context(name, context_hash)
      context = UseContext.context[name] ||= ContextStack.new
      context.push(context_hash)
      yield
    ensure
      context.pop if context
    end

    def use_context(name, *keys)
      context = UseContext.context[name]&.context || EmptyContext.instance

      if keys.empty?
        yield context
      else
        yield keys.map { |key| context[key] }
      end
    end
  end

  extend ContextMethods
end
