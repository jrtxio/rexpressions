# RegexMate - 正则表达式测试工具

<div align="center">
  <a href="README.md">
    <img alt="English" src="https://img.shields.io/badge/Language-English-blue.svg?style=flat-square">
  </a>
  <a href="#readme">
    <img alt="中文" src="https://img.shields.io/badge/语言-中文-red.svg?style=flat-square">
  </a>
</div>

## 📖 关于

RegexMate 是一个轻量级、基于 GUI 的正则表达式测试工具，使用 Racket 构建，专为重视 **用户控制、隐私优先、本地优先** 原则的开发者设计。

使用 RegexMate，您可以轻松地测试和调试正则表达式，并获得实时反馈，将工作组织到上下文环境中，并利用可选的 AI 辅助功能 - 所有这些都能保持您的数据本地存储和安全。

## ✨ 功能特性

### 核心功能
- **实时测试**：即时反馈正则表达式匹配结果
- **上下文管理**：将正则表达式工作组织到独立的上下文环境中
- **匹配高亮**：可视化高亮显示匹配的文本
- **语法验证**：实时正则表达式语法检查和错误报告
- **本地优先存储**：默认所有数据本地持久化
- **跨平台**：支持 Windows、macOS 和 Linux

### AI 集成（可选）
- **可控 AI 访问**：AI 仅在明确请求时访问数据
- **正则生成**：通过 AI 辅助生成正则表达式
- **智能建议**：获取 AI 驱动的正则表达式改进建议

### 设计原则
- **以用户为中心**：简洁、直观的三面板界面
- **隐私优先**：未经许可，任何数据都不会离开您的设备
- **模块化架构**：易于扩展和定制
- **持久化存储**：自动保存所有上下文

## 🚀 快速开始

### 先决条件

- [Racket 8.0+](https://racket-lang.org/download/)

### 安装

1. 克隆或下载仓库

```bash
git clone https://github.com/your-username/regexmate.git
cd regexmate
```

2. 运行应用程序

```bash
racket main.rkt
```

## 📖 使用说明

### 基本工作流程

1. **创建上下文**：点击左侧面板中的 `+` 按钮
2. **输入正则表达式**：在输入框中键入您的正则表达式
3. **添加测试文本**：输入要测试的示例文本
4. **查看结果**：匹配的文本将自动高亮显示
5. **保存更改**：所有更改都会自动保存

### 上下文管理

- **重命名上下文**：双击上下文名称
- **删除上下文**：选择上下文并点击 `-` 按钮
- **切换上下文**：点击列表中的任意上下文

### AI 辅助

1. 在 AI 面板中输入您的请求
2. 使用 `@input` 共享您的测试文本
3. 使用 `@current-regex` 共享您当前的正则表达式
4. AI 响应中的正则表达式将自动提取

## 📁 项目结构

```
regexmate/
├── main.rkt              # 主应用程序入口点
├── core/
│   ├── context.rkt       # 上下文管理
│   ├── regex-engine.rkt  # 正则表达式匹配和验证
│   └── storage.rkt       # 本地存储实现
├── gui/
│   ├── main-window.rkt   # 主应用程序窗口
│   ├── context-panel.rkt # 上下文列表面板
│   ├── regex-panel.rkt   # 正则表达式测试面板
│   └── ai-panel.rkt      # AI 助手面板
└── utils/
    ├── uuid.rkt          # UUID 生成
    └── ai-protocol.rkt   # AI 通信协议
```

## 🛠️ 开发

### 设置

1. 安装 [DrRacket](https://racket-lang.org/download/) 或 Racket CLI 工具
2. 在您喜欢的编辑器中打开项目
3. 运行 `racket main.rkt` 启动应用程序

### 贡献

欢迎贡献！请随时提交问题、功能请求或拉取请求。

1. Fork 仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开拉取请求

## 📄 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

## 🤝 贡献指南

请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解我们的行为准则以及提交拉取请求的流程。

## 📞 联系方式

如有问题或疑问，请在 GitHub 仓库上打开问题。

## 🙏 致谢

- 使用 [Racket](https://racket-lang.org/) 构建 ❤️
- 受各种正则表达式测试工具启发，专注于用户隐私和控制
