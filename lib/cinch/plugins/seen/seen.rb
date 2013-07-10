# -*- coding: utf-8 -*-
require 'cinch'
require 'cinch/toolbox'
require 'cinch-storage'
require 'cinch/cooldown'
require 'time-lord'

module Cinch::Plugins
  class Seen
    include Cinch::Plugin

    enforce_cooldown

    self.help = "Use .seen <name> to see the last time that nick was active."

    listen_to :channel

    match /seen ([^\s]+)\z/

    def initialize(*args)
      super
      @storage = CinchStorage.new(config[:filename] || 'yaml/seen.yml')
      @storage.data ||= {}
    end

    def listen(m)
      channel = m.channel.name
      @storage.data[channel] ||= Hash.new
      @storage.data[channel][m.user.nick.downcase] = Time.now
      @storage.synced_save(@bot)
    end

    def execute(m, nick)
      return if sent_via_pm?(m)
      unless m.user.nick.downcase == nick.downcase
        m.reply last_seen(m.channel.name, nick), true
      end
    end

    private

    def last_seen(channel, nick)
      @storage.data[channel] ||= Hash.new
      time = @storage.data[channel][nick.downcase]

      if time.nil?
        "I've never seen #{nick} before, sorry!"
      else
        "I last saw #{nick} #{time.ago.to_words}"
      end
    end

    def sent_via_pm?(m)
      return false unless m.channel.nil?
      m.reply "You must use that command in the main channel."
      true
    end
  end
end
