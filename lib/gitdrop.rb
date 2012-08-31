$: << File.expand_path("..", __FILE__)

require 'gitdrop/sync'
require 'gitdrop/cli'

module GitDrop
  # helper to post growl messages
  def self.message(msg, title = "GitDrop")
    msg = msg.gsub("'", '"')

    # post to growl (if we can)
    cmd = "growlnotify -m '#{msg}'"
    if title.to_s.strip.length > 0
      title = title.gsub("'", '"')
      cmd = "#{cmd} -t '#{title}'"
    end

    `#{cmd}`
  rescue => e
    puts "[gitdrop] #{title}: #{msg}"
  end
end