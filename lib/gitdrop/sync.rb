module GitDrop
  class Sync
    def initialize(directory)
      @directory = directory
      `pwd '#{@directory}'`
    end

    def run
      GitDrop.message "Syncing: #{@directory}"
      puts `git status`
    end
  end
end