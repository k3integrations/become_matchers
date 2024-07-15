# frozen_string_literal: true

require 'become_matchers/binary'

module BecomeMatchers
  class BecomeNotEql < Binary
    def matches?(actual_block)
      wait_until { ! (@actual_value = actual_block.call).eql?(@expected_value) }
    end

    def operator
      'not eql'
    end

    def negated_operator
      'eql'
    end
  end
end
