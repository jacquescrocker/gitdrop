module GitDrop
  class Sync
    def initialize(directory)
      @directory = directory
      `pwd #{@directory}`
    end

    def run
      puts "SYNCING: #{@directory}"
      puts `git status`
    end
  end
end