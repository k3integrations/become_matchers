# frozen_string_literal: true

require 'become_matchers/any_binary'

module BecomeMatchers
  class BecomeRaising < AnyBinary
    def matches?(actual_block)
      wait_until(**@options) do
        begin
          actual_block.call
        rescue *@expected_values => e
          @actual_value = e.class
          true
        rescue => e
          @actual_value = e.class
          raise
        else
          false
        end
      end
    end

    def operator
      'raising'
    end

    def negated_operator
      'not raising'
    end
  end
end
