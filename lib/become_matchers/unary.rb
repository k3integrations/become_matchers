# frozen_string_literal: true

require 'become_matchers/base'

module BecomeMatchers
  class Unary < Base
    def initialize(**options)
      @options = options
    end
  end
end
