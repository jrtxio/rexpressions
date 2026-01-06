# RegexMate - Regex Testing Tool

<div align="center">
  <a href="#readme">
    <img alt="English" src="https://img.shields.io/badge/Language-English-blue.svg?style=flat-square">
  </a>
  <a href="README_zh.md">
    <img alt="中文" src="https://img.shields.io/badge/语言-中文-red.svg?style=flat-square">
  </a>
</div>

RegexMate is a GUI-based regular expression testing tool built with Racket, designed for **user control, privacy-first, and local-first** principles.

## Features

### Core Functionality

- **Context Management**: Organize your regex work into independent contexts, each with its own regex pattern, test text, and metadata
- **Real-time Testing**: Test regex patterns against your text with instant feedback
- **Local-first Storage**: All data is persisted locally by default, with optional cloud sync planned
- **Controlled AI Integration**: Optional AI assistance with user-controlled access to your data
- **Cross-platform**: Works on Windows, macOS, and Linux
- **Highlighted Matches**: Visual highlighting of matched text in the GUI
- **Syntax Validation**: Real-time regex syntax checking and error reporting

### Technical Highlights

- **User-Centric Design**: Clean, intuitive three-panel interface
- **Privacy-First**: AI only accesses data when explicitly requested
- **Modular Architecture**: Easy to extend and customize
- **Persistent Storage**: Automatic saving of all contexts
- **UUID-based Contexts**: Unique identifiers for each work unit

## Installation

### Prerequisites

- [Racket 8.0+](https://racket-lang.org/download/)

### Setup

1. Clone or download the repository
2. Run the application:
   ```bash
   racket main.rkt
   ```

## Usage

### Basic Workflow

1. **Create a Context**: Click the `+` button in the left panel to create a new context
2. **Enter Regex**: Type your regular expression in the input field
3. **Add Test Text**: Enter sample text to test your regex against
4. **View Results**: Matched text will be highlighted in the test area
5. **Save Changes**: All changes are automatically saved to local storage

### Context Management

- **Rename Contexts**: Double-click a context name to edit it
- **Delete Contexts**: Select a context and click the `-` button
- **Switch Contexts**: Click on any context in the list to switch

### AI Assistance (Optional)

RegexMate includes an optional AI assistant that can help with regex generation and testing:

- Use `@input` to provide test text to AI
- Use `@current-regex` to share your current regex with AI
- AI responses with regex patterns will be automatically extracted and applied

## Project Structure

```
rexpressions/
├── main.rkt              # Main application entry point
├── core/
│   ├── context.rkt       # Context data structure and management
│   ├── regex-engine.rkt  # Regex matching and validation
│   └── storage.rkt       # Local storage implementation
├── gui/
│   ├── main-window.rkt   # Main application window
│   ├── context-panel.rkt # Context list panel
│   ├── regex-panel.rkt   # Regex testing panel
│   └── ai-panel.rkt      # AI assistant panel
└── utils/
    ├── uuid.rkt          # UUID generation
    └── ai-protocol.rkt   # AI communication protocol
```

## Storage

All contexts are stored locally in platform-specific locations:

- **Windows**: `%APPDATA%\RegexMate\contexts.rktd`
- **macOS**: `~/Library/Application Support/RegexMate/contexts.rktd`
- **Linux**: `~/.local/share/RegexMate/contexts.rktd`

## Technical Details

### Built With

- [Racket](https://racket-lang.org/) - The primary programming language
- [Racket GUI Library](https://docs.racket-lang.org/gui/overview.html) - For the graphical interface
- [Racket Regex Engine](https://docs.racket-lang.org/guide/regexp.html) - For regex processing

### Architecture

RegexMate follows a modular architecture with clear separation between:

1. **Core Logic**: Regex processing, context management, storage
2. **GUI Components**: Panel implementations, event handling
3. **Utilities**: Helper functions for UUID generation, AI communication

## Development

### Getting Started

1. Install [DrRacket](https://racket-lang.org/download/) or the Racket command-line tools
2. Open the project in DrRacket or your preferred editor
3. Run `racket main.rkt` to start the application

### Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow existing code style conventions
- Write clear, concise comments for complex logic
- Add tests for new functionality when appropriate

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Roadmap

### Version 1.0
- ✅ Core regex testing functionality
- ✅ Context management
- ✅ Local storage
- ✅ Basic AI integration
- ✅ Cross-platform support

### Version 2.0
- 🔄 Shareable context snapshots
- 🔄 Web viewer for shared contexts
- 🔄 Enhanced AI capabilities
- 🔄 Improved highlighting and navigation

### Future Plans
- 🔄 Team collaboration features
- 🔄 Regex template marketplace
- 🔄 Optional cloud sync
- 🔄 Plugin system for extending functionality

## Contact

For issues or questions, please open an issue on the GitHub repository.

## Acknowledgments

- Built with ❤️ using [Racket](https://racket-lang.org/)
- Inspired by various regex testing tools with a focus on user privacy and control

---

**RegexMate** - Empowering users with powerful regex tools while respecting privacy and control.
