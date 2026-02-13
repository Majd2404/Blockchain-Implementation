#!/usr/bin/env ruby

puts "\n🚀 Blockchain Visualizer Quick Start"
puts "=" * 60

# Check if Sinatra is installed
begin
  require 'sinatra'
  puts "✓ Sinatra detected"
rescue LoadError
  puts "❌ Sinatra not found. Installing dependencies..."
  system('gem install sinatra webrick')
  puts "\n✓ Dependencies installed!"
end

puts "\n🔗 Starting blockchain web server..."
puts "📡 Navigate to: http://localhost:4567"
puts "=" * 60
puts "\nPress Ctrl+C to stop the server\n\n"

# Start the server
load File.join(__dir__, 'server.rb')
