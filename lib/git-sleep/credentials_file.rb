require 'singleton'

module GitSleep
  class CredentialsFile
    include Singleton

    def present?
      File.exist?(path)
    end

    def destroy
      File.delete(path)
      true
    rescue Errno::ENOENT
      false
    end

    def path
      @path ||= File.expand_path('~/.netrc')
    end
  end
end

