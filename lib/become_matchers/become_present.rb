# frozen_string_literal: true

require 'become_matchers/unary'

module BecomeMatchers
  class BecomePresent < Unary
    def matches?(actual_block)
      wait_until { (@actual_value = actual_block.call).present? }
    end

    def short_description
      'present'
    end

    def short_negated_description
      'blank'
    end
  end
end
