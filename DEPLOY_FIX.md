# 🔧 部署问题修复指南

## 问题描述

部署到 GitHub Pages 后出现以下错误：
- ❌ GET `https://hughes-t.github.io/flutter_bootstrap.js` 404 (Not Found)
- ❌ GET `https://hughes-t.github.io/manifest.json` 404 (Not Found)
- ❌ StorageService not initialized 错误

## 已修复的问题

### 1. ✅ StorageService 初始化错误

**修复文件**: `lib/main.dart`

**修改内容**:
```dart
// 添加导入
import 'services/storage_service.dart';

// 在 main() 函数中初始化
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // 新增：初始化 StorageService
  await StorageService.init();

  runApp(...);
}
```

### 2. ✅ GitHub Pages 路径问题

**修复文件**: `web/index.html`

**添加内容**:
```html
<script>
  // GitHub Pages 404 fallback
  (function(){
    var redirect = sessionStorage.redirect;
    delete sessionStorage.redirect;
    if (redirect && redirect != location.href) {
      history.replaceState(null, null, redirect);
    }
  })();
</script>
```

### 3. ✅ 创建 404 页面

**新增文件**: `web/404.html`

用于处理 GitHub Pages 的 SPA 路由。

---

## 🚀 现在如何重新部署

### 方法 1: 使用 Flutter 命令（推荐）

如果你本地安装了 Flutter SDK：

```bash
# 1. 构建 Web 版本
flutter build web --release --base-href "/flutter_medical_demo/"

# 2. 进入构建目录
cd build/web

# 3. 初始化并推送
git init
git add .
git commit -m "Fix: Initialize StorageService and add GitHub Pages routing"
git branch -M gh-pages
git remote add origin https://github.com/hughes-T/flutter_medical_demo.git
git push -f origin gh-pages

# 4. 返回项目根目录
cd ../..
```

### 方法 2: 使用 Git Bash 或 PowerShell

```powershell
# 完整命令（一行）
flutter build web --release --base-href "/flutter_medical_demo/"; cd build/web; if (Test-Path ".git") { Remove-Item -Recurse -Force .git }; git init; git add .; git commit -m "Fix: Initialize StorageService"; git branch -M gh-pages; git remote add origin https://github.com/hughes-T/flutter_medical_demo.git 2>$null; git push -f origin gh-pages; cd ../..
```

---

## ✅ 验证部署成功

### 1. 等待 GitHub Pages 部署完成

访问 GitHub 仓库查看部署状态：
```
https://github.com/hughes-T/flutter_medical_demo/deployments
```

### 2. 访问在线演示

等待 1-3 分钟后访问：
```
https://hughes-t.github.io/flutter_medical_demo/
```

### 3. 检查控制台

按 `F12` 打开浏览器开发者工具：
- ✅ 控制台无红色错误
- ✅ Network 标签显示所有资源加载成功（200 状态）
- ✅ 应用正常运行，可以点击"立即体验"或"跳过"

---

## 🔍 已修复的具体错误

### 错误 1: StorageService not initialized

**原因**:
- `StorageService` 使用了单例模式
- 需要在应用启动时调用 `init()` 方法初始化 SharedPreferences
- 之前只调用了 `SharedPreferences.getInstance()` 但没有赋值给 `StorageService._prefs`

**解决方案**:
在 `main.dart` 中添加 `await StorageService.init()`

### 错误 2: 资源文件 404

**原因**:
- GitHub Pages 部署在子路径 `/flutter_medical_demo/`
- 资源路径需要正确的 base href
- 已通过 `--base-href` 参数解决

### 错误 3: SPA 路由问题

**原因**:
- GitHub Pages 不支持单页应用（SPA）路由
- 刷新页面或直接访问子路由会 404

**解决方案**:
- 添加 `404.html` 重定向到主页
- 使用 `sessionStorage` 保存路由并恢复

---

## 📋 部署检查清单

每次部署前确认：

- [ ] 修改了代码并保存
- [ ] 运行 `flutter build web --release --base-href "/flutter_medical_demo/"`
- [ ] 检查 `build/web` 目录生成成功
- [ ] 确认 `build/web/404.html` 存在
- [ ] Push 到 `gh-pages` 分支
- [ ] 等待 1-3 分钟
- [ ] 访问线上地址验证
- [ ] 检查浏览器控制台无错误

---

## 🎯 常见问题

### Q1: 为什么本地运行正常，部署后报错？

**A**: 本地开发使用的是开发服务器（`flutter run`），自动处理了很多配置。部署到 GitHub Pages 是静态文件托管，需要：
- 正确的 base href
- StorageService 必须显式初始化
- 处理 SPA 路由问题

### Q2: 每次修改代码都要重新 build 吗？

**A**:
- **本地开发**: 不需要，使用 `flutter run` + 热重载（按 `r`）
- **部署到线上**: 必须重新 `flutter build web`

### Q3: 如何快速测试修复是否成功？

**A**:
```bash
# 本地测试 Web 版本
flutter run -d chrome

# 或者启动本地服务器
cd build/web
python -m http.server 8000
# 访问 http://localhost:8000
```

---

## 📝 修复总结

| 文件 | 修改内容 | 状态 |
|------|---------|------|
| `lib/main.dart` | 添加 `StorageService.init()` | ✅ 已修复 |
| `web/index.html` | 添加 GitHub Pages 路由处理脚本 | ✅ 已修复 |
| `web/404.html` | 创建 404 重定向页面 | ✅ 已创建 |

---

## 🎉 下一步

修复完成后，重新部署：

```bash
flutter build web --release --base-href "/flutter_medical_demo/"
cd build/web
git init
git add .
git commit -m "Fix: StorageService initialization and GitHub Pages routing"
git branch -M gh-pages
git push -f origin gh-pages
cd ../..
```

然后访问：**https://hughes-t.github.io/flutter_medical_demo/**

享受你的新首页和训练页面吧！ 🚀
