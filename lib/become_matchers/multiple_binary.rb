# frozen_string_literal: true

require 'become_matchers/binary'

module BecomeMatchers
  class MultipleBinary < Binary
    def initialize(expected_values, options = {})
      @expected_values = Array(expected_values)
      super(options)
    end
  end
end
