# frozen_string_literal: true

require 'become_matchers/multiple_binary'

module BecomeMatchers
  class AnyBinary < MultipleBinary
    def expected_description
      @expected_values.length == 1 ? @expected_values.first.inspect : "any of #{@expected_values.map(&:to_s).join(', ')}"
    end
  end
end
