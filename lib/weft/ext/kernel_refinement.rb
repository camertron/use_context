# frozen_string_literal: true

require "weft"

module Weft
  module KernelRefinement
    refine Kernel do
      def provide_context(...)
        Weft.provide_context(...)
      end

      def use_context(...)
        Weft.use_context(...)
      end
    end
  end
end
