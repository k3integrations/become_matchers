# frozen_string_literal: true

require 'become_matchers/unary'

module BecomeMatchers
  class BecomeTruthy < Unary
    def matches?(actual_block)
      wait_until { !! (@actual_value = actual_block.call) }
    end

    def short_description
      'truthy'
    end

    def short_negated_description
      'falsy'
    end
  end
end
