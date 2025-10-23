# Flutter Medical Training Demo

[![GitHub Pages](https://img.shields.io/badge/demo-online-brightgreen)](https://hughes-t.github.io/flutter_medical_demo/)
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

一个基于 Flutter 的呼吸康复训练移动应用 Demo。

## 🌐 在线演示

**点击查看在线演示：** [https://hughes-t.github.io/flutter_medical_demo/](https://hughes-t.github.io/flutter_medical_demo/)

> 注意：在线演示为 Web 版本，最佳体验请使用 Chrome 或 Edge 浏览器访问。

## 功能特性

### 已实现功能

- ✅ **启动页（Splash Screen）**
  - 应用 Logo 展示
  - 淡入动画效果
  - 自动检测首次启动和登录状态

- ✅ **引导页（Onboarding）**
  - 2个引导屏幕展示
  - 支持左右滑动切换
  - 动画页面指示器
  - 跳过和下一步按钮

- ✅ **登录注册流程**
  - 手机号登录页面（支持表单验证）
  - 验证码输入页面（带倒计时重发功能）
  - 用户信息设置页面（昵称、性别、年龄段）

- ✅ **首页框架**
  - 底部导航栏（首页、训练、我的）
  - 首页：横幅、快捷入口、今日训练、训练计划
  - 训练页：训练模式选择、训练类型网格
  - 我的：用户信息卡片、功能菜单、退出登录

- ✅ **通用组件**
  - 自定义按钮（CustomButton）
  - 自定义输入框（CustomTextField）
  - 加载状态组件（LoadingWidget）

## 技术栈

### 核心依赖

- **flutter_riverpod**: 状态管理
- **shared_preferences**: 轻量级数据持久化
- **hive**: 复杂数据本地存储
- **dio**: 网络请求
- **cached_network_image**: 图片缓存
- **video_player / chewie**: 视频播放

### 项目架构

```
lib/
├── main.dart                     # 应用入口
├── app/                          # 应用配置
│   ├── routes.dart              # 路由配置
│   └── theme.dart               # 主题配置
├── core/                        # 核心功能
│   ├── constants/               # 常量定义
│   │   └── app_constants.dart
│   ├── utils/                   # 工具类
│   │   └── validators.dart
│   └── widgets/                 # 通用组件
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── loading_widget.dart
├── features/                    # 功能模块
│   ├── splash/                  # 启动页
│   │   └── presentation/pages/
│   ├── onboarding/              # 引导页
│   │   └── presentation/pages/
│   ├── auth/                    # 登录注册
│   │   ├── presentation/pages/
│   │   ├── providers/
│   │   └── models/
│   └── home/                    # 首页
│       └── presentation/pages/
└── services/                    # 服务层
    └── storage_service.dart     # 持久化服务
```

## 运行项目

### 环境要求

- Flutter SDK: >= 3.0.0
- Dart SDK: >= 3.0.0
- Android Studio / VS Code
- Android SDK (用于 Android 开发)
- Xcode (用于 iOS 开发，仅 macOS)

### 安装步骤

1. **克隆项目**
   ```bash
   cd flutter_medical_demo
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行项目**

   - Android:
     ```bash
     flutter run
     ```

   - iOS (需要 macOS):
     ```bash
     flutter run
     ```

   - Web:
     ```bash
     flutter run -d chrome
     ```

4. **构建发布版本**

   - Android APK:
     ```bash
     flutter build apk --release
     ```

   - iOS (需要 macOS):
     ```bash
     flutter build ios --release
     ```

## 使用指南

1. **首次启动**: 应用会显示启动页，然后进入引导页
2. **登录流程**:
   - 输入手机号（格式：1开头的11位数字）
   - 输入验证码（任意6位数字，Demo 环境下不会真实验证）
   - 设置用户信息（可选，可以跳过）
3. **主界面**: 登录后进入首页，可以通过底部导航栏切换不同页面

## 待扩展功能

根据原型图，后续可以扩展的功能包括：

- 🔲 儿童版/成人版训练模块详细页面
- 🔲 呼气、吸气、振荡训练功能实现
- 🔲 视频播放功能
- 🔲 设备连接功能（蓝牙）
- 🔲 训练数据统计和报告生成
- 🔲 图表展示（训练进度、成绩等）
- 🔲 训练计划管理
- 🔲 课程详情和视频课程

## 开发规范

### 代码风格

- 遵循 Flutter 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 组件命名采用大驼峰（PascalCase）
- 变量和函数命名采用小驼峰（camelCase）

### 提交规范

- feat: 新功能
- fix: 修复 bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 代码重构
- test: 测试相关
- chore: 构建/工具链更新

## 常见问题

### 1. 依赖安装失败

```bash
flutter pub cache repair
flutter pub get
```

### 2. iOS 构建失败

```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### 3. 模拟器无法连接

```bash
flutter devices
flutter doctor
```

## 截图

TODO: 添加应用截图

## 许可证

MIT License

## 联系方式

如有问题或建议，请联系开发团队。
