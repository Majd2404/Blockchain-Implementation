require_relative 'blockchain'

# =============================================================================
# EXAMPLE 1: Basic Cryptocurrency Transactions
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 1: Cryptocurrency Transaction Blockchain"
puts "=" * 60

# Create blockchain with difficulty 2 (faster for demo)
coin_chain = Blockchain.new(2)

# Simulate a series of transactions
transactions = [
  { from: "Majd", to: "Issam", amount: 50 },
  { from: "Issam", to: "Ahmed", amount: 25 },
  { from: "Ahmed", to: "Ridha", amount: 10 },
  { from: "Ridha", to: "Majd", amount: 5 }
]

transactions.each do |tx|
  coin_chain.add_block(tx.to_json)
end

coin_chain.display

# =============================================================================
# EXAMPLE 2: Document Verification System
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 2: Document Verification Blockchain"
puts "=" * 60

doc_chain = Blockchain.new(2)

# Simulate document hashing and timestamping
documents = [
  {
    type: "contract",
    title: "Service Agreement",
    hash: Digest::SHA256.hexdigest("Contract content here"),
    author: "Legal Department"
  },
  {
    type: "certificate",
    title: "Degree Certificate",
    hash: Digest::SHA256.hexdigest("Certificate data"),
    author: "University Registrar"
  },
  {
    type: "report",
    title: "Q4 Financial Report",
    hash: Digest::SHA256.hexdigest("Report data"),
    author: "Finance Team"
  }
]

documents.each do |doc|
  doc_chain.add_block(doc.to_json)
end

doc_chain.display

# =============================================================================
# EXAMPLE 3: Supply Chain Tracking
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 3: Supply Chain Tracking Blockchain"
puts "=" * 60

supply_chain = Blockchain.new(2)

# Track product journey
shipments = [
  {
    event: "manufactured",
    product: "Laptop Model X",
    location: "Factory - Shenzhen",
    quantity: 1000
  },
  {
    event: "quality_check",
    product: "Laptop Model X",
    location: "QA Facility - Shenzhen",
    passed: true
  },
  {
    event: "shipped",
    product: "Laptop Model X",
    from: "Shenzhen Port",
    to: "Los Angeles Port",
    carrier: "Ocean Freight Co"
  },
  {
    event: "received",
    product: "Laptop Model X",
    location: "Distribution Center - LA",
    quantity: 1000
  },
  {
    event: "delivered",
    product: "Laptop Model X",
    to: "Retail Store #123",
    quantity: 50
  }
]

shipments.each do |shipment|
  supply_chain.add_block(shipment.to_json)
end

supply_chain.display

# =============================================================================
# EXAMPLE 4: Demonstrating Tamper Detection
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 4: Tamper Detection Demonstration"
puts "=" * 60

tamper_chain = Blockchain.new(2)

# Add some blocks
tamper_chain.add_block({ data: "Original Data 1" }.to_json)
tamper_chain.add_block({ data: "Original Data 2" }.to_json)
tamper_chain.add_block({ data: "Original Data 3" }.to_json)

puts "\n✓ Original blockchain is valid:"
puts "Valid: #{tamper_chain.valid?}"

# Attempt to tamper with block #1
puts "\n⚠️  Tampering with block #1..."
tamper_chain.chain[1].instance_variable_set(:@data, "TAMPERED DATA!!!")

puts "\n✗ After tampering, blockchain is invalid:"
puts "Valid: #{tamper_chain.valid?}"

tamper_chain.display

# =============================================================================
# EXAMPLE 5: JSON Export
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 5: Exporting Blockchain to JSON"
puts "=" * 60

export_chain = Blockchain.new(2)
export_chain.add_block({ user: "Majd", action: "login" }.to_json)
export_chain.add_block({ user: "Issam", action: "purchase" }.to_json)

json_output = export_chain.to_json
puts "\nBlockchain as JSON:"
puts JSON.pretty_generate(JSON.parse(json_output))

# =============================================================================
# EXAMPLE 6: Difficulty Comparison
# =============================================================================

puts "\n" + "=" * 60
puts "EXAMPLE 6: Mining Difficulty Comparison"
puts "=" * 60

difficulties = [1, 2, 3, 4]

difficulties.each do |diff|
  puts "\n--- Testing Difficulty: #{diff} ---"
  
  start_time = Time.now
  test_chain = Blockchain.new(diff)
  test_chain.add_block({ test: "data" }.to_json)
  end_time = Time.now
  
  elapsed = end_time - start_time
  nonce = test_chain.chain.last.nonce
  
  puts "Time to mine: #{elapsed.round(4)} seconds"
  puts "Final nonce: #{nonce}"
  puts "Hash: #{test_chain.chain.last.hash}"
end

puts "\n" + "=" * 60
puts "All examples completed!"
puts "=" * 60
