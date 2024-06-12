# frozen_string_literal: true

module BecomeMatchers
  class Base
    DEFAULT_WAIT = 2
    DEFAULT_RETRY_INTERVAL = 0.1
  
    def default_wait
      # default_wait_time was deprecated/renamed to default_max_wait_time in Capybara 2.5, and removed in Capybara 3.0
      Capybara.respond_to?(:default_max_wait_time) ? Capybara.default_max_wait_time : Capybara.respond_to?(:default_wait_time) ? Capybara.default_wait_time : DEFAULT_WAIT
    end
  
    def default_retry_interval
      # default_retry_interval was introduced in Capybara 3.40
      Capybara.respond_to?(:default_retry_interval) ? Capybara.default_retry_interval : DEFAULT_RETRY_INTERVAL
    end

    def defaults(options)
      {wait: default_wait, retry_interval: default_retry_interval}.merge(options)
    end

    def supports_block_expectations?
      true
    end

    def wait_until(options)
      options = defaults(options)
  
      loop_start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      while ! yield
        return false if (Process.clock_gettime(Process::CLOCK_MONOTONIC) - loop_start_time) > options[:wait]
        sleep options[:retry_interval]
      end
      true
    end
  
    def description
      "become #{short_description} (#{how_long_description})"
    end

    def failure_message
      "\nexpected to become: #{short_description} (#{how_long_description})\nas of last try got: #{@actual_value.inspect}\n"
    end

    def failure_message_when_negated
      "\nexpected to become: #{short_negated_description} (#{how_long_description})\nas of last try got: #{@actual_value.inspect}\n"
    end

    def how_long
      @options[:wait] || default_wait
    end
  
    def how_long_description
      "within #{how_long} #{how_long == 1 ? 'second' : 'seconds'}"
    end
  end
end
