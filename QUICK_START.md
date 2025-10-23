# 快速启动指南

## 前提条件

在开始之前，请确保您已安装 Flutter SDK。如果还没有安装，请参考以下步骤：

### 安装 Flutter

1. **下载 Flutter SDK**
   - 访问 [Flutter 官网](https://flutter.dev/docs/get-started/install)
   - 选择您的操作系统（Windows/macOS/Linux）
   - 下载最新稳定版本

2. **配置环境变量**（Windows）
   ```bash
   # 将 Flutter bin 目录添加到系统 PATH
   # 例如：C:\flutter\bin
   ```

3. **验证安装**
   ```bash
   flutter doctor
   ```

## 运行项目

### 1. 进入项目目录
```bash
cd flutter_medical_demo
```

### 2. 安装依赖
```bash
flutter pub get
```

### 3. 检查设备连接
```bash
flutter devices
```

您应该能看到以下设备之一：
- Android 模拟器/真机
- iOS 模拟器/真机（仅 macOS）
- Chrome 浏览器
- Windows/macOS/Linux 桌面

### 4. 运行项目

**使用 Android 模拟器：**
```bash
flutter run
```

**使用 Chrome 浏览器：**
```bash
flutter run -d chrome
```

**使用 Windows 桌面：**
```bash
flutter run -d windows
```

## 项目结构说明

```
flutter_medical_demo/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── app/                   # 应用配置（路由、主题）
│   ├── core/                  # 核心功能（常量、工具、通用组件）
│   ├── features/              # 功能模块
│   │   ├── splash/           # 启动页
│   │   ├── onboarding/       # 引导页
│   │   ├── auth/             # 登录注册
│   │   └── home/             # 首页
│   └── services/             # 服务层（存储、网络等）
├── pubspec.yaml              # 项目配置和依赖
└── README.md                 # 项目文档
```

## 功能演示流程

1. **启动应用** → 显示启动页（2秒）
2. **引导页** → 滑动查看2个引导屏幕 → 点击"立即体验"
3. **登录** → 输入手机号（如：13800138000）→ 点击"获取验证码"
4. **验证码** → 输入6位验证码（如：123456）→ 点击"验证"
5. **用户信息** → 设置昵称、性别、年龄段 → 点击"完成"（或跳过）
6. **首页** → 浏览首页内容 → 切换底部导航栏

## 常用命令

```bash
# 获取依赖
flutter pub get

# 清理构建缓存
flutter clean

# 运行项目（开发模式）
flutter run

# 运行项目（发布模式）
flutter run --release

# 构建 APK
flutter build apk

# 构建 iOS（仅 macOS）
flutter build ios

# 查看所有可用设备
flutter devices

# 检查 Flutter 环境
flutter doctor

# 升级 Flutter
flutter upgrade

# 查看日志
flutter logs
```

## 开发建议

### VS Code 推荐插件
- Flutter
- Dart
- Flutter Widget Snippets
- Awesome Flutter Snippets

### Android Studio 推荐插件
- Flutter Plugin
- Dart Plugin

## 遇到问题？

### 1. 依赖安装失败
```bash
flutter pub cache repair
flutter pub get
```

### 2. 构建失败
```bash
flutter clean
flutter pub get
flutter run
```

### 3. 模拟器无法识别
- **Android**: 确保 Android Studio 已安装并配置了 AVD
- **iOS**: 确保 Xcode 已安装（仅 macOS）

### 4. 查看详细错误信息
```bash
flutter doctor -v
```

## 下一步

- 浏览 [README.md](README.md) 了解完整功能
- 查看 [Flutter 官方文档](https://flutter.dev/docs)
- 学习 [Dart 语言](https://dart.dev/guides)

## 技术支持

如果您在使用过程中遇到问题，请：
1. 查看 Flutter 官方文档
2. 搜索 Stack Overflow
3. 访问 Flutter 中文社区

祝您使用愉快！
