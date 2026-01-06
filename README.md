# RegexMate - Regex Testing Tool

<div align="center">
  <a href="#readme">
    <img alt="English" src="https://img.shields.io/badge/Language-English-blue.svg?style=flat-square">
  </a>
  <a href="README_zh.md">
    <img alt="中文" src="https://img.shields.io/badge/语言-中文-red.svg?style=flat-square">
  </a>
</div>

## 📖 About

RegexMate is a lightweight, GUI-based regular expression testing tool built with Racket, designed for developers who value **user control, privacy-first, and local-first** principles.

With RegexMate, you can easily test and debug regular expressions with real-time feedback, organize your work into contexts, and leverage optional AI assistance - all while keeping your data local and secure.

## ✨ Features

### Core Functionality
- **Real-time Testing**: Instant feedback on regex matches
- **Context Management**: Organize regex work into independent contexts
- **Highlighted Matches**: Visual highlighting of matched text
- **Syntax Validation**: Real-time regex syntax checking and error reporting
- **Local-first Storage**: All data persisted locally by default
- **Cross-platform**: Works on Windows, macOS, and Linux

### AI Integration (Optional)
- **Controlled AI Access**: AI only accesses data when explicitly requested
- **Regex Generation**: Generate regex patterns with AI assistance
- **Smart Suggestions**: Get AI-powered suggestions for regex improvements

### Design Principles
- **User-Centric**: Clean, intuitive three-panel interface
- **Privacy-First**: No data leaves your machine without permission
- **Modular Architecture**: Easy to extend and customize
- **Persistent Storage**: Automatic saving of all contexts

## 🚀 Getting Started

### Prerequisites

- [Racket 8.0+](https://racket-lang.org/download/)

### Installation

1. Clone or download the repository

```bash
git clone https://github.com/your-username/regexmate.git
cd regexmate
```

2. Run the application

```bash
racket main.rkt
```

## 📖 Usage

### Basic Workflow

1. **Create a Context**: Click the `+` button in the left panel
2. **Enter Regex**: Type your regex pattern in the input field
3. **Add Test Text**: Enter sample text to test against
4. **View Results**: Matched text will be highlighted automatically
5. **Save Changes**: All changes are saved automatically

### Context Management

- **Rename Contexts**: Double-click a context name
- **Delete Contexts**: Select a context and click the `-` button
- **Switch Contexts**: Click any context in the list

### AI Assistance

1. Type your request in the AI panel
2. Use `@input` to share your test text
3. Use `@current-regex` to share your current regex
4. AI responses with regex patterns will be automatically extracted

## 📁 Project Structure

```
regexmate/
├── main.rkt              # Main application entry point
├── core/
│   ├── context.rkt       # Context management
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

## 🛠️ Development

### Setup

1. Install [DrRacket](https://racket-lang.org/download/) or Racket CLI tools
2. Open the project in your preferred editor
3. Run `racket main.rkt` to start the application

### Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## 📞 Contact

For issues or questions, please open an issue on the GitHub repository.

## 🙏 Acknowledgments

- Built with ❤️ using [Racket](https://racket-lang.org/)
- Inspired by various regex testing tools with a focus on user privacy and control
