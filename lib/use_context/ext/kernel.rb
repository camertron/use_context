# frozen_string_literal: true

require "use_context"

module Kernel
  include UseContext::ContextMethods
  extend UseContext::ContextMethods
end
