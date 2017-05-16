# MONKEY Patch to ignore whining about unknown commands when
# => multiple slack bots are running with the same token.

module SlackRubyBot
  module Commands
    class Unknown < Base
      match(/^(?<bot>\S*)[\s]*(?<expression>.*)$/)

      def self.call(_client, _data, _match)
      end
    end

    class About < SlackRubyBot::Commands::Base
      command 'about', 'hi', 'help' do |client, data, match|
      end
    end
  end
end
