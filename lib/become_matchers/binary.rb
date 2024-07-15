# frozen_string_literal: true

require 'become_matchers/base'

module BecomeMatchers
  class Binary < Base
    def initialize(expected_value, options = {})
      @expected_value = expected_value
      super(options)
    end

    def expected_description
      @expected_value.inspect
    end

    def short_description
      "#{operator} #{expected_description}"
    end

    def short_negated_description
      "#{negated_operator} #{expected_description}"
    end
  end
end
