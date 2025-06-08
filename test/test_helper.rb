# frozen_string_literal: true

require "weft/ext/kernel_refinement"
require "minitest/autorun"

if ENV["WEFT_ISOLATION_LEVEL"] == "fiber"
  Weft.isolation_level = :fiber
else
  Weft.isolation_level = :thread
end

puts "Weft isolation level set to #{Weft.isolation_level}"
