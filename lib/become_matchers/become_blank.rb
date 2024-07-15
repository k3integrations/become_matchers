# frozen_string_literal: true

require 'become_matchers/unary'

module BecomeMatchers
  class BecomeBlank < Unary
    def matches?(actual_block)
      wait_until { (@actual_value = actual_block.call).blank? }
    end

    def short_description
      'blank'
    end

    def short_negated_description
      'present'
    end
  end
end
