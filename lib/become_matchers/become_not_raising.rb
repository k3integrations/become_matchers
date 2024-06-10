# frozen_string_literal: true

require 'become_matchers/any_binary'

module BecomeMatchers
  class BecomeNotRaising < AnyBinary
    def matches?(actual_block)
      wait_until(**@options) do
        begin
          actual_block.call
        rescue *@expected_values => e
          ! @expected_values.include?(@actual_value = e.class)
        else
          true
        end
      end
    end

    def operator
      'not raising'
    end

    def negated_operator
      'raising'
    end
  end
end
