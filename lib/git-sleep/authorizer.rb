require 'netrc'
require 'singleton'
require_relative './credentials_file'

module GitSleep
  class Authorizer
    include Singleton

    # add credentials to user's netrc file
    def xid=(xid)
      netrc['gitsleep.com'] = xid, 'no_password'
      netrc.save
    end

    def setup?
      credentials_file.present? && !credentials.nil? && valid_keys?
    end

    def xid
      validate_setup
      credentials.first
    end

    private

    def validate_setup
      raise GitSleep::NotSetupError unless setup?
    end

    def valid_keys?
      credentials.length == 2
    end

    def credentials
      netrc['gitsleep.com']
    end

    def netrc
      @netrc ||= Netrc.read(credentials_file.path).tap do |netrc|
        netrc.new_item_prefix = "\n# jawbone xid\n"
      end
    end

    def credentials_file
      CredentialsFile.instance
    end
  end
end

