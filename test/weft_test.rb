# frozen_string_literal: true

require "test_helper"

class WeftTest < Minitest::Test
  def test_provide_context_from_weft_constant
    value = Weft.provide_context(:test, { key: :value_from_weft_constant }) do
      Weft.use_context(:test) do |context|
        context[:key]
      end
    end

    assert_equal :value_from_weft_constant, value
  end
end
