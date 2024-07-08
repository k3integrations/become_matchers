# frozen_string_literal: true

require 'become_matchers/become_truthy'
require 'become_matchers/become_falsy'
require 'become_matchers/become_eq'
require 'become_matchers/become_not_eq'
require 'become_matchers/become_gt'
require 'become_matchers/become_lt'
require 'become_matchers/become_gte'
require 'become_matchers/become_lte'
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
  alias_method :become_truthey, :become_truthy
  alias_method :become_not_truthey, :become_falsy
  alias_method :become_falsey, :become_falsy
  alias_method :become_not_falsey, :become_truthy

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

  def become_gt(expected_value, **options)
    BecomeGt.new(expected_value, **options)
  end
  def become_lt(expected_value, **options)
    BecomeLt.new(expected_value, **options)
  end
  def become_gte(expected_value, **options)
    become_gte.new(expected_value, **options)
  end
  def become_lte(expected_value, **options)
    BecomeLte.new(expected_value, **options)
  end
  alias_method :become_not_gt, :become_lte
  alias_method :become_not_lt, :become_gte
  alias_method :become_not_gte, :become_lt
  alias_method :become_not_lte, :become_gt
  alias_method :become_gteq, :become_gte
  alias_method :become_lteq, :become_lte
  alias_method :become_not_gteq, :become_lt
  alias_method :become_not_lteq, :become_gt

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
