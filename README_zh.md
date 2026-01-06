# RegexMate - 正则表达式测试工具

<div align="center">
  <a href="README.md">
    <img alt="English" src="https://img.shields.io/badge/Language-English-blue.svg?style=flat-square">
  </a>
  <a href="#readme">
    <img alt="中文" src="https://img.shields.io/badge/语言-中文-red.svg?style=flat-square">
  </a>
</div>

RegexMate是一个基于Racket构建的GUI正则表达式测试工具，设计遵循**用户控制、隐私优先、本地优先**的原则。

## 功能特性

### 核心功能

- **上下文管理**：将正则表达式工作组织到独立的上下文中，每个上下文都有自己的正则模式、测试文本和元数据
- **实时测试**：使用即时反馈测试正则表达式与文本的匹配
- **本地优先存储**：默认所有数据都本地持久化，计划支持可选的云同步
- **可控AI集成**：可选的AI辅助功能，用户控制数据访问权限
- **跨平台**：支持Windows、macOS和Linux
- **匹配高亮**：GUI中可视化高亮显示匹配文本
- **语法验证**：实时正则表达式语法检查和错误报告

### 技术亮点

- **以用户为中心的设计**：简洁、直观的三面板界面
- **隐私优先**：AI仅在明确请求时访问数据
- **模块化架构**：易于扩展和定制
- **持久化存储**：自动保存所有上下文
- **UUID标识上下文**：每个工作单元的唯一标识符

## 安装

### 先决条件

- [Racket 8.0+](https://racket-lang.org/download/)

### 设置

1. 克隆或下载仓库
2. 运行应用程序：
   ```bash
   racket main.rkt
   ```

## 使用

### 基本工作流程

1. **创建上下文**：点击左侧面板中的 `+` 按钮创建新上下文
2. **输入正则表达式**：在输入框中输入正则表达式
3. **添加测试文本**：输入要测试正则表达式的示例文本
4. **查看结果**：匹配的文本将在测试区域中高亮显示
5. **保存更改**：所有更改会自动保存到本地存储

### 上下文管理

- **重命名上下文**：双击上下文名称进行编辑
- **删除上下文**：选择上下文并点击 `-` 按钮
- **切换上下文**：点击列表中的任意上下文进行切换

### AI辅助（可选）

RegexMate包含可选的AI助手，可以帮助生成和测试正则表达式：

- 使用 `@input` 向AI提供测试文本
- 使用 `@current-regex` 与AI共享当前正则表达式
- AI响应中的正则表达式将自动提取并应用

## 项目结构

```
rexpressions/
├── main.rkt              # 主应用程序入口点
├── README.md             # 英文版README
├── README_zh.md          # 中文版README
├── core/
│   ├── context.rkt       # 上下文数据结构和管理
│   ├── regex-engine.rkt  # 正则表达式匹配和验证
│   ├── storage.rkt       # 本地存储实现
│   └── readme-manager.rkt # README管理功能
├── gui/
│   ├── main-window.rkt   # 主应用程序窗口
│   ├── context-panel.rkt # 上下文列表面板
│   ├── regex-panel.rkt   # 正则表达式测试面板
│   ├── ai-panel.rkt      # AI助手面板
│   └── readme-panel.rkt  # README显示面板
└── utils/
    ├── uuid.rkt          # UUID生成
    └── ai-protocol.rkt   # AI通信协议
```

## 存储

所有上下文都存储在平台特定位置的本地文件中：

- **Windows**：`%APPDATA%\RegexMate\contexts.rktd`
- **macOS**：`~/Library/Application Support/RegexMate/contexts.rktd`
- **Linux**：`~/.local/share/RegexMate/contexts.rktd`

## 技术细节

### 构建技术

- [Racket](https://racket-lang.org/) - 主要编程语言
- [Racket GUI库](https://docs.racket-lang.org/gui/overview.html) - 用于图形界面
- [Racket正则表达式引擎](https://docs.racket-lang.org/guide/regexp.html) - 用于正则表达式处理

### 架构

RegexMate遵循模块化架构，明确分离：

1. **核心逻辑**：正则表达式处理、上下文管理、存储
2. **GUI组件**：面板实现、事件处理
3. **工具**：UUID生成、AI通信等辅助函数

## 开发

### 入门

1. 安装 [DrRacket](https://racket-lang.org/download/) 或Racket命令行工具
2. 在DrRacket或首选编辑器中打开项目
3. 运行 `racket main.rkt` 启动应用程序

### 贡献

欢迎贡献！请随时提交问题、功能请求或拉取请求。

1. Fork仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开拉取请求

### 代码风格

- 遵循现有代码风格约定
- 为复杂逻辑编写清晰、简洁的注释
- 适当为新功能添加测试

## 许可证

本项目采用MIT许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

## 路线图

### 版本1.0
- ✅ 核心正则表达式测试功能
- ✅ 上下文管理
- ✅ 本地存储
- ✅ 基本AI集成
- ✅ 跨平台支持

### 版本2.0
- 🔄 可共享的上下文快照
- 🔄 共享上下文的Web查看器
- 🔄 增强的AI功能
- 🔄 改进的高亮和导航

### 未来计划
- 🔄 团队协作功能
- 🔄 正则表达式模板市场
- 🔄 可选的云同步
- 🔄 用于扩展功能的插件系统

## 联系方式

如有问题或疑问，请在GitHub仓库上打开问题。

## 致谢

- 使用 [Racket](https://racket-lang.org/) 构建 ❤️
- 受各种正则表达式测试工具启发，专注于用户隐私和控制

---

**RegexMate** - 在尊重隐私和控制的同时，为用户提供强大的正则表达式工具。