# Crackers - The Hash Cracking Bot
require 'colorize'

# TODO: Try every cracking method returned by hashid

class Crackers
  attr_accessor :hash_priority, :target_hash, :force_crack

  # https://hashcat.net/wiki/doku.php?id=example_hashes
  def initialize(hash_arg)
    @hash_priority = ['0', # MD5
                      '100', # Sha1
                      '500', # MD5Crypt
                      '1000', # NTLM
                      '1400', # sha256
                      '1700', # sha512
                      '1800', # sha512 crypt
                      '3000', # LM
                      '1300', # SHA224
                      '900'] # MD4
    @force_crack = false
    @target_hash = hash_arg
  end

  # For implementation from command line
  def run
    if @target_hash.nil?
      puts 'USAGE: ruby crackers.rb <HASH>'
      return
    end
    hash_id = determine_hash_type[1]
    if hash_id.nil?
      puts "#{'[-]'.red} Could not identify hash type"
      return nil
    end
    found_password = crack_hash(hash_id)
    if found_password.nil?
      puts "#{'[-]'.red} Could not crack hash"
      return nil
    else
      puts "#{'[*]'.blue} Password: #{found_password}"
      return found_password
    end
  end

  # Runs hashid and returns name and number
  def determine_hash_type
    # Prevent invalid characters
    hash_regex = /[\w:=+$\.\/]+/
    verified_hash = hash_regex.match(@target_hash)
    return nil if verified_hash[0] != @target_hash

    # Prevent hashid from opening files
    return nil if File.exist?(@target_hash)

    # Return if hashid does not return a hash type
    output = `hashid -m '#{@target_hash}' | grep Hashcat`
    return nil if output.empty?
    output = output.split('\n')

    # Parse out the name and number of the selected has type
    regex = /\[\+\] (.+) \[Hashcat Mode: (\d+)\]/
    regex_output = regex.match(output.first)

    puts "#{'[+]'.green} Hash Type Detected: #{regex_output.captures[0]} - #{regex_output.captures[1]}"
    regex_output.captures
  end

  def crack_hash(hash_id)
    # Run hashcat on the hash using the selected hashid
    crack_output = `hashcat #{'--potfile-disable' if @force_crack} -m #{hash_id} '#{@target_hash}' rockyou.txt`

    # If Status == Exhausted, then the crack was not successful
    if crack_output.include? 'Status.........: Exhausted'
      return nil
    else
      # Check if the hack has been cracked previously
      if crack_output.include? 'hash found in pot file'
        crack_output = `hashcat -m #{hash_id} --show '#{@target_hash}'`
      end

      # Parse out the password from the output
      crack_output.split("\n").each { |line| return line.split(':').last if line.include? "#{@target_hash}:" }
    end
  end
end

# Crackers.new(ARGV[0]).run
