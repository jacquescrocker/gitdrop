module GitDrop
  class Sync
    def initialize(directory)
      @directory = directory
      `pwd '#{@directory}'`
    end

    def run
      GitDrop.message "Syncing: #{@directory}"

      puts `git add .`
      puts `git commit -am 'auto saving (with GitDrop)'`
      puts `git pull`
      puts `git push`
    end
  end
end