# frozen_string_literal: true

require "weft"

module Kernel
  include Weft::ContextMethods
  extend Weft::ContextMethods
end
