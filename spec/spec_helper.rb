# report test coverage when on CI
# that env variable is set there
if ENV['BLINK_182_DRUMMER'] == 'TRAVIS'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'pry'
require_relative './../lib/git-sleep'
require_relative './support/netrc_helpers'

RSpec.configure do |config|
  config.before(:each) do
    # stub the path method so we can avoid touching the tester's netrc file
    allow_any_instance_of(GitSleep::CredentialsFile).to receive(:path)
      .and_return(test_netrc_path)

    # delete the test file
    GitSleep::CredentialsFile.instance.destroy

    # reset singletons before each test
    Singleton.__init__(GitSleep::CredentialsFile)
    Singleton.__init__(GitSleep::Authorizer)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # should I use this?
  # config.disable_monkey_patching!

  config.raise_errors_for_deprecations!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  # config.profile_examples = 2

  config.order = :random
end

