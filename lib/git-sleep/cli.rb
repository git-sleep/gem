require_relative './hook_installer'
require_relative './metadata'

module GitSleep
  class Cli
    def self.start
      if command = ARGV.first
        command = command.to_sym
      end
      new.start(command)
    end

    def start(command)
      case command
      when :init then init!
      when :authorize then authorize!
      when :'-v' then version!
      else
        send_help!
      end
    end

    private

    def version!
      puts "Git Sleep v#{GitSleep::VERSION}"
    end

    def authorize!
      puts "Visit #{GitSleep::OUR_SITE} to get the necessary information"
      puts 'what is your xid?'
      print '> '
      auth.xid = $stdin.gets.chomp
    end

    def init!
      raise NotGitRepoError unless Dir.entries(current_path).include?('.git')

      puts 'Install the pre-commit hook that prevents commits when you' \
        " haven't sleep enough?"
      HookInstaller.install('pre-commit') if user_consents?

      puts 'Install the post-commit hook that adds git notes about your sleep' \
        ' data?'
      HookInstaller.install('post-commit') if user_consents?
    end

    def send_help!
      puts help_text
    end

    def auth
      GitSleep::Authorizer.instance
    end

    def help_text
      "Available commands:\n  git sleep authorize\n  git sleep init"
    end

    def current_path
      File.expand_path('.')
    end

    def user_consents?
      print 'Is it okay? [y/n] '
      $stdin.gets.chomp == 'y'
    end
  end
end

