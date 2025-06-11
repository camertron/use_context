# frozen_string_literal: true

require "use_context"

module UseContext
  module KernelRefinement
    refine Kernel do
      def provide_context(...)
        UseContext.provide_context(...)
      end

      def use_context(...)
        UseContext.use_context(...)
      end
    end
  end
end
