# frozen_string_literal: true

require 'become_matchers/become_truthy'
require 'become_matchers/become_falsy'
require 'become_matchers/become_eq'
require 'become_matchers/become_not_eq'
require 'become_matchers/become_eql'
require 'become_matchers/become_not_eql'
require 'become_matchers/become_present'
require 'become_matchers/become_blank'
require 'become_matchers/become_raising'
require 'become_matchers/become_not_raising'

module BecomeMatchers
  def become_truthy(**options)
    BecomeTruthy.new(**options)
  end
  def become_falsy(**options)
    BecomeFalsy.new(**options)
  end
  alias_method :become_not_truthy, :become_falsy
  alias_method :become_not_falsy, :become_truthy

  def become_eq(expected_value, **options)
    BecomeEq.new(expected_value, **options)
  end
  def become_not_eq(expected_value, **options)
    BecomeNotEq.new(expected_value, **options)
  end

  def become_eql(expected_value, **options)
    BecomeEql.new(expected_value, **options)
  end
  def become_not_eql(expected_value, **options)
    BecomeNotEql.new(expected_value, **options)
  end

  def become_present(**options)
    BecomePresent.new(**options)
  end
  def become_blank(**options)
    BecomeBlank.new(**options)
  end
  alias_method :become_not_present, :become_blank
  alias_method :become_not_blank, :become_present

  def become_raising(expected_values, **options)
    BecomeRaising.new(expected_values, **options)
  end
  def become_not_raising(expected_values, **options)
    BecomeNotRaising.new(expected_values, **options)
  end
end

begin
  require 'rspec/core'
rescue LoadError
else
  if defined?(RSpec)
    RSpec::configure do |config|
      config.include(BecomeMatchers)
    end
  end
end
