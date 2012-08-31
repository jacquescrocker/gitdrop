require 'fileutils'

module GitDrop

  class CLI
    def initialize(args)
      @args = args
    end

    def run
      case @args.first
      when "sync"
        sync
      when "start"
        start
      when "stop"
        stop
      end
    end

    def sync
      Sync.new(working_directory).run
    end

    def start
      create_config
      gitignore_config

      # puts launchctl_config_path
      # puts launchctl_config_contents

      # create launchctl file
      FileUtils.mkdir_p(File.dirname(launchctl_config_path))
      File.open(launchctl_config_path, 'w') {|f| f.write(launchctl_config_contents) }

      # load launchctl
      unload if is_loaded?
      load
    end

    def stop
      # delete launchctl file
      if File.exists?(launchctl_config_path)
        unload
        FileUtils.rm(launchctl_config_path)
      end

      remove_config
    end


    protected
    def load
      puts `launchctl load -F #{launchctl_config_path}`
    end

    def unload
      puts `launchctl unload #{launchctl_config_path}`
    end

    def is_loaded?
      result = `launchctl list`
      result.include?(label)
    end

    def working_directory
      File.expand_path(".")
    end

    def home
      File.expand_path("~")
    end

    def label
      "ai.lizi.gitdrop"+working_directory.gsub("/", "-").downcase
    end

    def config_directory
      "#{working_directory}/.gitdrop"
    end

    def template_file
      File.read(File.expand_path("../../templates/ai.lizi.gitdrop.plist", __FILE__))
    end

    def executable_path
      File.expand_path("../../../bin/gitdrop", __FILE__)
    end

    def launchctl_config_contents
      inject_vars(template_file.to_s)
    end

    def launchctl_config_path
      "#{home}/Library/LaunchAgents/#{label}.plist"
    end

    # creates the log folder in working directory
    def create_config
      FileUtils.mkdir_p(config_directory)
    end

    def gitignore_config
      # TODO: add .gitdrop to .gitignore
    end

    # removes the log folder
    def remove_config
      FileUtils.rm_rf(config_directory)
    end

    def inject_vars(body)
      body = body.dup

      {
        "%label%" => label,
        "%executable%" => executable_path,
        "%interval%" => 60,
        "%workingdirectory%" => working_directory,
        "%configdirectory%" => config_directory,
      }.each do |key, val|
        body.gsub!(key.to_s, val.to_s)
      end

      body
    end
  end
end

