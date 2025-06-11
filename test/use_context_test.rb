# frozen_string_literal: true

require "test_helper"

class UseContextTest < Minitest::Test
  def test_provide_context_from_uc_constant
    value = UseContext.provide_context(:test, { key: :value_from_uc_constant }) do
      UseContext.use_context(:test) do |context|
        context[:key]
      end
    end

    assert_equal :value_from_uc_constant, value
  end
end
