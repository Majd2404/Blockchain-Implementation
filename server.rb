require 'sinatra'
require 'json'
require_relative 'blockchain'

# Configuration
set :port, 4567
set :bind, '0.0.0.0'
set :public_folder, File.dirname(__FILE__)

# Global blockchain instance
$blockchain = Blockchain.new(3)

# Serve the main page
get '/' do
  send_file File.join(settings.public_folder, 'blockchain_visualizer.html')
end

# API Endpoints
get '/api/chain' do
  content_type :json
  {
    chain: $blockchain.chain.map { |block|
      {
        index: block.index,
        timestamp: block.timestamp,
        data: block.data,
        previous_hash: block.previous_hash,
        hash: block.hash,
        nonce: block.nonce
      }
    },
    difficulty: $blockchain.difficulty,
    valid: $blockchain.valid?
  }.to_json
end

post '/api/mine' do
  content_type :json
  
  data = JSON.parse(request.body.read)
  block_data = data['data'] || "Block #{$blockchain.chain.length}"
  
  begin
    start_time = Time.now
    $blockchain.add_block(block_data)
    end_time = Time.now
    
    {
      success: true,
      block: {
        index: $blockchain.chain.last.index,
        hash: $blockchain.chain.last.hash,
        nonce: $blockchain.chain.last.nonce
      },
      mining_time: (end_time - start_time).round(2)
    }.to_json
  rescue => e
    status 500
    { success: false, error: e.message }.to_json
  end
end

post '/api/difficulty' do
  content_type :json
  
  data = JSON.parse(request.body.read)
  new_difficulty = data['difficulty'].to_i
  
  if new_difficulty >= 1 && new_difficulty <= 6
    $blockchain.instance_variable_set(:@difficulty, new_difficulty)
    { success: true, difficulty: new_difficulty }.to_json
  else
    status 400
    { success: false, error: 'Difficulty must be between 1 and 6' }.to_json
  end
end

post '/api/tamper' do
  content_type :json
  
  data = JSON.parse(request.body.read)
  index = data['index'].to_i
  new_data = data['data'] || 'TAMPERED'
  
  if index >= 0 && index < $blockchain.chain.length
    $blockchain.chain[index].instance_variable_set(:@data, new_data)
    { success: true, message: "Block #{index} tampered" }.to_json
  else
    status 400
    { success: false, error: 'Invalid block index' }.to_json
  end
end

get '/api/validate' do
  content_type :json
  { valid: $blockchain.valid? }.to_json
end

post '/api/reset' do
  content_type :json
  
  difficulty = $blockchain.difficulty
  $blockchain = Blockchain.new(difficulty)
  
  { success: true, message: 'Blockchain reset' }.to_json
end

# Start message
puts "\n" + "="*60
puts "🔗 Blockchain Web Server Starting..."
puts "="*60
puts "\n📡 Server running at: http://localhost:4567"
puts "🌐 Open your browser and navigate to the URL above"
puts "\n💡 API Endpoints:"
puts "   GET  /api/chain     - Get full blockchain"
puts "   POST /api/mine      - Mine new block"
puts "   POST /api/difficulty - Set difficulty"
puts "   POST /api/tamper    - Tamper with block"
puts "   GET  /api/validate  - Validate chain"
puts "   POST /api/reset     - Reset blockchain"
puts "\n" + "="*60 + "\n"
