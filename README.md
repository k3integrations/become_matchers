# RSpec Become Matchers

When writing RSpec tests, there are some situations where you may find it useful to wait a short moment for a given block of code to return an expected value.  Capybara used to have a `wait_until` helper method that served this purpose.  But because "almost" all situations are better handled in other ways, and it was being mass abused by the community, they removed it.

"Almost"...  There are **rare** situations where you need that functionality back.  But this functionality is still better handled by an RSpec matcher that waits instead of a helper method, because RSpec matchers already have succinct syntax that is easy to read and write, and very helpful error messages when tests fail.

These RSpec become matchers are meant to fill the gap.

## Getting started

### Setup:

```ruby
# Gemfile
gem 'become_matchers', group: :test
```


### Usage:

```ruby
it "should show email for a newly created user" do
  email = "john@example.com"

  visit new_user_path
  fill_in "Email", with: email
  fill_in "Password", with: "secret-password"
  click_button "Save"

  user = nil
  expect { user = User.find_by(email: email) }.to become_present

  visit user_path(user)

  expect(page).to have_content(email)
end
```

## Documentation

### Here is the current list of become matchers:

* `become_truthy`
* `become_falsy`
* `become_eq expected_value`
* `become_eql expected_value`
* `become_gt other_value`
* `become_lt other_value`
* `become_gte other_value`
* `become_lte other_value`
* `become_present`
* `become_blank`

All of these support natural RSpec matcher negation, and some of these are negative versions of others, and they all have `become_not_*` versions or aliases.  Use whichever one makes the most sense in your situation.

All of these support these optional parameters:
* `wait` which defaults to `Capybara.default_max_wait_time`
* `retry_interval` which defaults to `Capybara.default_retry_interval`

There are many more similar waiting matchers that can be added... as we need them.

### Note: Normally you should never need this gem!

Normally you should do something like this instead:

```ruby
  # ...
  click_button "Save"

  expect(page).to have_selector('.notification', text: 'Saved Successfully!')
  user = User.find_by(email: email)

  visit user_path(user)
  # ...
```

**However**: in the real world due to curcumstances outside of developer control, sometimes you do not or cannot have a well-formed app that provides any visual feedback to wait for (such as a flash message, a new page, etc)... and **that** is an example of when you would benefit from this gem!  So please try hard **not** to use this gem... and then if you need it anyway, here it is.

### Note: if you have a capybara selector in your test block like this:

```ruby
expect { first('input', wait: 0, minimum: 0)&.value }.to become_eq 'expected value'
```

 then you normally need to have:
 * a `wait: 0` in it, so it doesn't wait for the element to show up!  The `become_eq` matcher already internally waits, loops, and retries, so your test block shouldn't do so also (that would defeat the purpose)...
 * In Capybara 3 and later you need a `minimum: 0` in there so it doesn't raise an error if the element isn't there yet.  This way `become_eq` can properly wait for it to show up instead (as well as testing for its value equality).

**Note again: normally you should not need this either.**  Normally you should do this instead:

```ruby
expect(page).to have_field('Example Label', with: 'expected value')
```

but there are some rare situations where you may find `become_eq` more useful, such as when your html code is not well formed with good selectors, or your entry fields aren't actual form input tags, etc.  Again, try to avoid this gem, but if you have to, here it is!

## Design principles of this gem internally

Waiting for something to happen in Ruby is so simple that most people don't seem to think it needs a gem.  There are lots of gists out there showing how to do it in just a couple lines, after all...  But there are a few caveats to making it work reliably:

* Don't use Ruby's `Timeout.timeout`!  It's tempting, and it works fine most of the time, but sometimes it has issues with cleaning up code from your code block when the timeout is triggered.  This is especially evident if you use third party libraries that call native code in your code block (think: mysql2 or chromedriver)!  Instead, just loop, and check elapsed time between each loop.  This has the drawback that a long running loop can take longer, or a hanging loop can hang your test suite, but given those things are evidence of a deeper issue that needs fixing anyway, then that is a small price to pay for general stability overall.

* Don't use `Time.now` (or similar) to check elapsed time, if you can help it on your platform.  The issue is when NTP sets your clock back and forth, you end up waiting too long or too short.  Sometimes even too short and your test fails!  Instead, always use `Process.clock_gettime(Process::CLOCK_MONOTONIC)` when available. This is obviously longer to type, especially in a gist, but it's a small price to pay for general stability.

* Use an RSpec matcher instead of a helper, which was already [discussed above](#rspec-become-matchers).

## Other similar gems

* <https://github.com/laserlemon/rspec-wait> - a bit different syntax than this gem, and more complicated internally...  but a more complete set of things you can do with it.

## Contributing

Feel free to fork and submit a good pull request, or submit an issue if you find one.

## Compatibility

* [Ruby](https://www.ruby-lang.org/) 2 or above
* [RSpec](https://rspec.info/) 3 or above
* [Active Support](https://guides.rubyonrails.org/active_support_core_extensions.html) - only for `become_present` and `become_blank` matchers.

## Versioning

[Semantic Versioning](https://semver.org)
