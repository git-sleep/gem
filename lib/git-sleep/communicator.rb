require 'singleton'
require 'httparty'

module GitSleep
  class Communicator
    include Singleton

    def can_connect?
      reset_data!
      true
    # TODO: be more specific
    # only rescue httparty error related to inability to connect
    rescue StandardError
      false
    end

    def happy_response?
      response.code == 200
    end

    def not_signed_up_response?
      response.code == 401
    end

    def not_signed_up_message
      "Must first authorize at #{GitSleep::OUR_SITE}\n" \
        'Then run `git sleep authorize`'
    end

    def can_commit?
      data['can_commit']
    end

    def hours_of_sleep
      data['sleep24']
    end

    def username
      ENV['USER']
    end

    private

    def data
      @data ||= response.parsed_response
    end

    def response
      @response ||= HTTParty.get(
        need_sleep_url,
        timeout: 2,
        body: {
          xid: auth.xid
        }
      )
    end

    def reset_data!
      @response = nil
      @data = nil
      data
    end

    def need_sleep_url
      'http://www.gitsleep.com/api/need_sleep'
    end

    def auth
      Authorizer.instance
    end
  end
end

