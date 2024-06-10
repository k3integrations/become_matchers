# frozen_string_literal: true

require 'become_matchers/binary'

module BecomeMatchers
  class BecomeEql < Binary
    def matches?(actual_block)
      wait_until(**@options) { (@actual_value = actual_block.call).eql? @expected_value }
    end

    def operator
      'eql'
    end

    def negated_operator
      'not eql'
    end
  end
end
