module GitSleep
  class HookInstaller
    def self.install(event)
      new(event).install
    end

    attr_reader :event

    def initialize(event)
      @event = event
    end

    def install
      (return unless ok_to_overwrite?) if File.exist?(new_hook_path)
      move_hook_code_into_place
      make_hook_executable
      puts 'Hook installed and made executable'
    end

    private

    def ok_to_overwrite?
      puts already_exists_warning_text
      print 'Is it okay? [y/n] '
      $stdin.gets.chomp == 'y'
    end

    def move_hook_code_into_place
      File.open(new_hook_path, 'w') do |f|
        f.write hook_code
      end
    end

    def make_hook_executable
      `chmod a+x #{new_hook_path}`
    end

    def hook_code
      File.read(hook_code_path)
    end

    def hook_code_path
      File.expand_path("../../hooks/#{event}", __FILE__)
    end

    def new_hook_path
      current_path + '/.git/hooks'
    end

    # TODO: make sure this will be the path the user is currently in
    def current_path
      File.expand_path('.')
    end

    def already_exists_warning_text
      "you already have a #{event} hook and we don't want to overwrite it..."
    end
  end
end

