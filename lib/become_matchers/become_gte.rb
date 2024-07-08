# frozen_string_literal: true

require 'become_matchers/binary'

module BecomeMatchers
  class BecomeGte < Binary
    def matches?(actual_block)
      wait_until(**@options) { (@actual_value = actual_block.call) >= @expected_value }
    end

    def operator
      '>='
    end

    def negated_operator
      '<'
    end
  end
end
