# 🚀 Installation & Setup Guide

## Quick Start (3 steps)

### Option 1: Automated Start (Easiest)

```bash
ruby start.rb
```

This will automatically install dependencies and start the server!

### Option 2: Manual Setup

1. **Install dependencies**:
```bash
bundle install
# OR
gem install sinatra webrick
```

2. **Start the web server**:
```bash
ruby server.rb
```

3. **Open your browser**:
Navigate to `http://localhost:4567`

---

## Detailed Installation

### Prerequisites

- **Ruby**: Version 2.5 or higher
  - Check your version: `ruby --version`
  - Install from: https://www.ruby-lang.org/en/downloads/

- **Bundler** (Optional, but recommended):
```bash
gem install bundler
```

### Step-by-Step Setup

#### 1. Clone or Download the Repository

```bash
git clone <your-repo-url>
cd ruby-blockchain
```

#### 2. Install Dependencies

**Using Bundler (Recommended)**:
```bash
bundle install
```

**Or install gems manually**:
```bash
gem install sinatra
gem install webrick
```

#### 3. Run the Application

**Option A: Web Interface** (Interactive Visualization)
```bash
ruby server.rb
```
Then open `http://localhost:4567` in your browser.

**Option B: Command Line** (Terminal Interface)
```bash
ruby blockchain.rb
```

**Option C: Examples** (See Multiple Demos)
```bash
ruby examples.rb
```

---

## Web Interface Features

Once the server is running, you can:

### 1. Mine New Blocks
- Enter custom transaction data in JSON format
- Click "⛏️ Mine New Block"
- Watch the real-time mining animation

### 2. Adjust Difficulty
- Use the slider to change mining difficulty (1-5)
- Higher difficulty = more computation needed
- See the impact on mining time

### 3. Validate Chain
- Click "✓ Validate Chain" to check integrity
- Green = Valid blockchain
- Red = Tampered/Invalid blockchain

### 4. Test Security
- Enter a block index
- Click "⚠️ Tamper Block" to modify data
- Validate to see how tampering is detected

### 5. Reset Chain
- Start fresh with a new genesis block
- Maintains current difficulty setting

---

## Troubleshooting

### Port Already in Use

If port 4567 is already in use, edit `server.rb`:

```ruby
set :port, 4568  # Change to any available port
```

### Gem Installation Errors

**Permission Issues**:
```bash
sudo gem install sinatra webrick
# OR use --user-install flag
gem install sinatra webrick --user-install
```

**Ruby Version Too Old**:
Update Ruby to 2.5+ or use a version manager like rbenv or rvm.

### Browser Not Opening Automatically

Manually navigate to:
```
http://localhost:4567
```

Or if you changed the port:
```
http://localhost:YOUR_PORT
```

---

## API Usage Examples

### Get Blockchain Data
```bash
curl http://localhost:4567/api/chain
```

### Mine a New Block
```bash
curl -X POST http://localhost:4567/api/mine \
  -H "Content-Type: application/json" \
  -d '{"data": {"from":"Alice","to":"Bob","amount":100}}'
```

### Change Difficulty
```bash
curl -X POST http://localhost:4567/api/difficulty \
  -H "Content-Type: application/json" \
  -d '{"difficulty": 4}'
```

### Validate Blockchain
```bash
curl http://localhost:4567/api/validate
```

---

## File Structure

```
ruby-blockchain/
├── blockchain.rb              # Core blockchain implementation
├── server.rb                  # Web server (Sinatra)
├── blockchain_visualizer.html # Frontend interface
├── examples.rb                # Demo scripts
├── start.rb                   # Quick start script
├── Gemfile                    # Ruby dependencies
├── README.md                  # Documentation
├── INSTALL.md                 # This file
├── LICENSE                    # MIT License
└── .gitignore                # Git ignore rules
```

---

## Next Steps

1. ✅ **Start the server**: `ruby server.rb`
2. 🌐 **Open browser**: Navigate to `http://localhost:4567`
3. ⛏️ **Mine blocks**: Add transaction data and mine
4. 🔍 **Experiment**: Try tampering and validation
5. 📚 **Learn**: Read the code comments to understand blockchain concepts

---

## Additional Resources

- **README.md**: Comprehensive documentation
- **examples.rb**: Six different usage examples
- **blockchain.rb**: Well-commented source code

---

## Need Help?

- Check the README.md for detailed API documentation
- Review examples.rb for usage patterns
- Read inline code comments for implementation details

---

**Enjoy exploring blockchain technology! 🔗⛓️**
