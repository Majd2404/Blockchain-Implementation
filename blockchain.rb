require 'digest'
require 'json'
require 'time'

# Block class represents a single block in the blockchain
# Each block contains:
# - index: position in the chain
# - timestamp: when the block was created
# - data: the actual content/transactions
# - previous_hash: cryptographic link to the previous block
# - hash: this block's unique identifier
# - nonce: number used in proof-of-work mining
class Block
  attr_reader :index, :timestamp, :data, :previous_hash, :hash, :nonce

  def initialize(index, data, previous_hash)
    @index = index
    @timestamp = Time.now.to_i
    @data = data
    @previous_hash = previous_hash
    @nonce = 0
    @hash = calculate_hash
  end

  # Calculate the SHA-256 hash of the block
  # This creates a unique fingerprint based on all block data
  def calculate_hash
    sha = Digest::SHA256.new
    sha.update("#{@index}#{@timestamp}#{@data}#{@previous_hash}#{@nonce}")
    sha.hexdigest
  end

  # Proof of Work: mine the block by finding a hash with leading zeros
  # Difficulty determines how many leading zeros are required
  # This makes it computationally expensive to add blocks (security)
  def mine_block(difficulty)
    # Create a target string of zeros based on difficulty
    target = "0" * difficulty
    
    # Keep incrementing nonce until we find a valid hash
    until @hash.start_with?(target)
      @nonce += 1
      @hash = calculate_hash
    end
    
    puts "Block mined: #{@hash}"
  end

  # Display block information in a readable format
  def to_s
    <<~BLOCK
      Block ##{@index}
      Timestamp: #{Time.at(@timestamp)}
      Data: #{@data}
      Previous Hash: #{@previous_hash}
      Hash: #{@hash}
      Nonce: #{@nonce}
    BLOCK
  end
end

# Blockchain class manages the entire chain of blocks
# Responsibilities:
# - Maintain the chain integrity
# - Add new blocks with mining
# - Validate the entire chain
class Blockchain
  attr_reader :chain, :difficulty

  def initialize(difficulty = 2)
    @chain = []
    @difficulty = difficulty
    # Create the genesis block (first block in the chain)
    create_genesis_block
  end

  # The genesis block is special - it has no previous hash
  # It's hardcoded to ensure everyone starts with the same chain
  def create_genesis_block
    genesis_block = Block.new(0, "Genesis Block", "0")
    genesis_block.mine_block(@difficulty)
    @chain << genesis_block
  end

  # Get the most recent block in the chain
  def get_latest_block
    @chain.last
  end

  # Add a new block to the chain
  # The new block references the previous block's hash
  # This creates the "chain" - if you change an old block,
  # all subsequent hashes become invalid
  def add_block(data)
    previous_block = get_latest_block
    new_block = Block.new(
      @chain.length,
      data,
      previous_block.hash
    )
    
    puts "\nMining block #{new_block.index}..."
    new_block.mine_block(@difficulty)
    @chain << new_block
    
    puts "Block added successfully!\n"
  end

  # Validate the entire blockchain
  # Checks:
  # 1. Each block's hash is correctly calculated
  # 2. Each block properly references the previous block
  # 3. All blocks meet the proof-of-work difficulty requirement
  def valid?
    (1...@chain.length).each do |i|
      current_block = @chain[i]
      previous_block = @chain[i - 1]

      # Check if current block's hash is valid
      if current_block.hash != current_block.calculate_hash
        puts "Invalid hash at block #{i}"
        return false
      end

      # Check if current block properly references previous block
      if current_block.previous_hash != previous_block.hash
        puts "Invalid previous hash at block #{i}"
        return false
      end

      # Check if block meets difficulty requirement
      target = "0" * @difficulty
      unless current_block.hash.start_with?(target)
        puts "Block #{i} doesn't meet difficulty requirement"
        return false
      end
    end

    true
  end

  # Display the entire blockchain
  def display
    puts "\n" + "="*60
    puts "BLOCKCHAIN (Difficulty: #{@difficulty})"
    puts "="*60
    
    @chain.each do |block|
      puts block
      puts "-"*60
    end
    
    puts "Chain is #{valid? ? 'VALID ✓' : 'INVALID ✗'}"
    puts "="*60
  end

  # Export blockchain to JSON format
  def to_json
    {
      difficulty: @difficulty,
      chain: @chain.map do |block|
        {
          index: block.index,
          timestamp: block.timestamp,
          data: block.data,
          previous_hash: block.previous_hash,
          hash: block.hash,
          nonce: block.nonce
        }
      end
    }.to_json
  end
end

# =============================================================================
# DEMO: Example usage of the blockchain
# =============================================================================

if __FILE__ == $0
  puts "\n🔗 Simple Blockchain Implementation in Ruby"
  puts "=" * 60

  # Create a new blockchain with difficulty of 3
  # Higher difficulty = more computation needed = more secure
  blockchain = Blockchain.new(3)

  # Add some blocks with transaction data
  blockchain.add_block({
    from: "Majd",
    to: "Issam",
    amount: 50
  }.to_json)

  blockchain.add_block({
    from: "Issam",
    to: "Ahmed",
    amount: 25
  }.to_json)

  blockchain.add_block({
    from: "Ahmed",
    to: "Majd",
    amount: 10
  }.to_json)

  # Display the complete blockchain
  blockchain.display

  # Demonstrate tampering detection
  puts "\n🔍 Attempting to tamper with block #1..."
  blockchain.chain[1].instance_variable_set(:@data, "TAMPERED DATA")
  
  puts "\nValidating blockchain after tampering..."
  blockchain.display
end
