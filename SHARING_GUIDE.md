# 项目分享指南

本文档介绍如何将此 Flutter Demo 分享给其他开发者。

---

## 🚀 快速分享（推荐）

### 方法 1：GitHub + 在线演示

#### 第一步：发布到 GitHub

```bash
# 1. 初始化 Git（如果还没有）
git init

# 2. 添加 .gitignore
echo "# Flutter
.dart_tool/
.packages
.pub/
build/
*.lock

# IDE
.idea/
.vscode/
*.iml" > .gitignore

# 3. 提交代码
git add .
git commit -m "Initial commit: Flutter medical training demo"

# 4. 创建 GitHub 仓库后关联
git remote add origin https://github.com/你的用户名/flutter_medical_demo.git
git push -u origin main
```

#### 第二步：部署 Web 演示

```bash
# 1. 构建 Web 版本
flutter build web --release --base-href "/flutter_medical_demo/"

# 2. 安装 gh-pages 工具（首次）
npm install -g gh-pages

# 3. 部署到 GitHub Pages
cd build/web
git init
git add .
git commit -m "Deploy"
git branch -M gh-pages
git remote add origin https://github.com/你的用户名/flutter_medical_demo.git
git push -f origin gh-pages

# 4. 在 GitHub 仓库设置中启用 GitHub Pages
# Settings -> Pages -> Source: gh-pages branch
```

#### 分享链接：
- **代码仓库**：`https://github.com/你的用户名/flutter_medical_demo`
- **在线演示**：`https://你的用户名.github.io/flutter_medical_demo/`

---

### 方法 2：构建 APK 分享

**适合快速体验，无需安装开发环境**

```bash
# 1. 构建 Release APK
flutter build apk --release

# 2. APK 文件位置
# build/app/outputs/flutter-apk/app-release.apk
```

#### 分享方式：

**选项 A：蒲公英（推荐）**
1. 访问：https://www.pgyer.com/
2. 上传 APK
3. 获得二维码和下载链接

**选项 B：直接发送**
- 微信/QQ 发送 APK 文件
- 上传到百度网盘/阿里云盘

**选项 C：fir.im**
1. 访问：https://fir.im/
2. 上传 APK
3. 获得短链接

---

### 方法 3：压缩包分享

**最简单，适合内部分享**

#### Windows PowerShell：
```powershell
# 进入上级目录
cd d:\my_project\demo1023

# 压缩项目
Compress-Archive -Path flutter_medical_demo -DestinationPath flutter_medical_demo.zip
```

#### 分享方式：
- 百度网盘
- 阿里云盘
- 公司内部文件服务器
- 邮件附件（如果不太大）

#### 接收者使用步骤：
```bash
# 1. 解压文件
# 2. 打开终端进入项目目录
cd flutter_medical_demo

# 3. 安装依赖
flutter pub get

# 4. 运行项目
flutter run -d chrome  # Web 版
# 或
flutter run -d windows  # Windows 桌面版
```

---

## 📱 针对不同受众的分享方式

### 给开发者查阅代码

**推荐：GitHub/Gitee**

```bash
git clone https://github.com/你的用户名/flutter_medical_demo.git
cd flutter_medical_demo
flutter pub get
flutter run
```

---

### 给产品经理/设计师预览

**推荐：在线演示 + APK**

- **Web 演示**：直接发送链接，浏览器打开
- **APK 文件**：Android 手机直接安装体验

---

### 给投资人/客户展示

**推荐：视频演示 + 在线 Demo**

1. **录制演示视频**：
   - 使用 OBS Studio 录屏
   - 讲解主要功能
   - 上传到 Bilibili/YouTube

2. **准备演示文档**：
   - 项目介绍 PPT
   - 功能说明文档
   - 在线演示链接

---

## 🌐 部署 Web 演示的其他平台

### Netlify（最简单）

```bash
# 1. 构建 Web
flutter build web --release

# 2. 访问 https://www.netlify.com/
# 3. 拖拽 build/web 目录到页面
# 4. 立即获得在线链接
```

### Vercel

```bash
# 1. 安装 Vercel CLI
npm i -g vercel

# 2. 构建并部署
flutter build web --release
cd build/web
vercel
```

### Firebase Hosting

```bash
# 1. 安装 Firebase CLI
npm install -g firebase-tools

# 2. 登录 Firebase
firebase login

# 3. 初始化项目
firebase init hosting

# 4. 构建并部署
flutter build web --release
firebase deploy
```

---

## 📝 准备分享材料

### 创建详细的 README

在项目根目录的 README.md 中添加：

```markdown
# Flutter Medical Training Demo

## 在线演示
🌐 [点击查看在线演示](https://你的用户名.github.io/flutter_medical_demo/)

## 功能特性
- ✅ 完整的登录注册流程
- ✅ 引导页设计
- ✅ 首页框架
- ✅ 自定义 UI 组件库

## 快速开始

\`\`\`bash
# 克隆项目
git clone https://github.com/你的用户名/flutter_medical_demo.git

# 进入目录
cd flutter_medical_demo

# 安装依赖
flutter pub get

# 运行项目
flutter run -d chrome
\`\`\`

## 项目截图
[添加截图]

## 技术栈
- Flutter 3.x
- Riverpod
- Hive
- Dio

## 许可证
MIT
```

### 添加项目截图

在项目中创建 `screenshots/` 目录，添加：
- 启动页截图
- 引导页截图
- 登录页截图
- 首页截图

在 README 中引用：
```markdown
![启动页](screenshots/splash.png)
![首页](screenshots/home.png)
```

---

## 🎬 录制演示视频

### 录屏工具推荐

**Windows**：
- Xbox Game Bar（Win + G，系统自带）
- OBS Studio（专业，免费）
- Bandicam（简单易用）

**录制内容建议**：
1. 启动应用（2秒）
2. 引导页滑动（5秒）
3. 登录流程（10秒）
4. 首页功能展示（10秒）
5. 各个 Tab 切换（5秒）

### 视频分享平台
- **国内**：Bilibili、腾讯视频
- **国际**：YouTube
- **技术社区**：掘金、CSDN

---

## 📊 分享检查清单

发布前确认：

- [ ] 代码已提交到 Git
- [ ] README.md 已完善
- [ ] 添加了项目截图
- [ ] 在线演示可访问
- [ ] APK 可以正常安装运行
- [ ] 文档说明清晰
- [ ] 联系方式已添加

---

## 💡 额外建议

### 添加许可证

创建 `LICENSE` 文件（MIT License）：

```
MIT License

Copyright (c) 2025 [你的名字]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

### 添加贡献指南

创建 `CONTRIBUTING.md`：

```markdown
# 贡献指南

感谢你对本项目的关注！

## 如何贡献
1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request
```

---

## 📧 获取反馈

分享后收集反馈的方式：

1. **GitHub Issues** - 问题和建议
2. **GitHub Discussions** - 讨论和交流
3. **邮件** - 直接联系
4. **问卷调查** - 腾讯问卷、金数据

---

## 🎉 总结

**推荐的完整分享方案**：

1. **代码托管**：GitHub/Gitee
2. **在线演示**：GitHub Pages/Netlify
3. **移动体验**：APK（蒲公英）
4. **文档说明**：完善的 README
5. **视频演示**：Bilibili（可选）

这样可以满足不同人群的需求！

祝你的 Demo 分享顺利！🚀