# frozen_string_literal: true

require 'become_matchers/unary'

module BecomeMatchers
  class BecomeFalsy < Unary
    def matches?(actual_block)
      wait_until(**@options) { ! (@actual_value = actual_block.call) }
    end

    def short_description
      'falsy'
    end

    def short_negated_description
      'truthy'
    end
  end
end
