require 'slack-ruby-bot'
require 'dotenv'
require 'net/http'
require 'uri'
require_relative 'hide_defaults'
require_relative 'crackers'

Dotenv.load

SlackRubyBot::Client.logger.level = Logger::WARN

# Creates and alias between the crackers emoji and hackerbot
SlackRubyBot.configure do |config|
  config.aliases = %w(:crackers: hackerbot)
end

class CrackersBot < SlackRubyBot::Bot
  command 'crack' do |client, data, _match|
    # Parse command line arguments and ensure it's valid
    target_hash = data.text.split(' ')[2]
    if target_hash.nil?
      client.say(text: 'USAGE: :crackers: crack <HASH>', channel: data.channel)
      next
    end

    crackers = Crackers.new(target_hash)
    hash_type, hash_id = crackers.determine_hash_type
    if hash_id.nil?
      client.say(text: ':x: Could not identify hash type', channel: data.channel)
      next
    end
    client.say(text: ":heavy_check_mark: Hash Type Detected: #{hash_type}...", channel: data.channel)
    client.say(text: ':clock1: Starting Crack...', channel: data.channel)
    found_password = crackers.crack_hash(hash_id)
    if found_password.nil?
      client.say(text: ':x: Could not crack hash', channel: data.channel)
      next
    else
      client.say(text: ":black_small_square: Password: #{found_password}", channel: data.channel)
      next
    end
  end
end

CrackersBot.run
