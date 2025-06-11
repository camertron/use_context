# frozen_string_literal: true

require "singleton"

module UseContext
  @isolation_level = nil

  Thread.attr_accessor :uc_context
  Fiber.attr_accessor :uc_context

  class << self
    attr_reader :isolation_level, :scope

    def isolation_level=(level)
      return if level == @isolation_level

      unless %i(thread fiber).include?(level)
        raise ArgumentError, "isolation_level must be `:thread` or `:fiber`, got: `#{level.inspect}`"
      end

      @scope =
        case level
        when :thread; Thread
        when :fiber; Fiber
        end

      current.uc_context&.clear if @isolation_level

      @isolation_level = level
    end

    def current
      scope.current
    end

    def context
      current.uc_context ||= {}
    end
  end

  self.isolation_level = :thread

  class EmptyContext
    include Singleton

    def [](_key)
      nil
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

    def use_context(name)
      yield UseContext.context[name]&.context || EmptyContext.instance
    end
  end

  extend ContextMethods
end

if ENV["USE_CONTEXT_ISOLATION_LEVEL"] == "fiber"
  UseContext.isolation_level = :fiber
else
  UseContext.isolation_level = :thread
end
