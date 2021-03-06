# -*- coding: utf-8 -*-
require 'cinch'
require 'cinch/toolbox'
require 'cinch/storage'
require 'cinch/cooldown'
require 'time-lord'

module Cinch
  module Plugins
    # plugin to allow users to see when other users were last active
    class Seen
      include Cinch::Plugin

      # Simple object used to track users.
      Activity = Struct.new(:nick, :time, :message)

      enforce_cooldown
      self.help = 'Use .seen <name> to see the last time that nick was active.'
      listen_to :channel
      match(/seen ([^\s]+)\z/)

      def initialize(*args)
        super
        @storage = Cinch::Storage.new(config[:filename] || 'yaml/seen.yml')
        @storage.data ||= {}
      end

      def listen(m)
        channel = m.channel.name
        nick = m.user.nick
        @storage.data[channel] ||= {}
        @storage.data[channel][nick.downcase] =
          Activity.new(nick, Time.now, m.message)
        @storage.synced_save(@bot)
      end

      def execute(m, nick)
        return if Cinch::Toolbox.sent_via_private_message?(m) ||
                  m.user.nick.downcase == nick.downcase
        m.reply last_seen(m.channel.name, nick), true
      end

      private

      def last_seen(channel, nick)
        @storage.data[channel] ||= {}
        activity = @storage.data[channel][nick.downcase]

        if activity.nil?
          "I've never seen #{nick} before, sorry!"
        else
          "I last saw #{activity.nick} #{activity.time.ago.to_words} " \
          "saying '#{activity.message}'"
        end
      end
    end
  end
end
