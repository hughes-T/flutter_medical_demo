# 快速部署指南

## 方法一：使用部署脚本（推荐）

```powershell
# 在项目根目录运行
.\deploy.ps1
```

脚本会自动：
- ✅ 重新构建最新代码
- ✅ 创建 gh-pages 分支
- ✅ 推送到 GitHub

---

## 方法二：手动部署步骤

### 1. 构建 Web 版本
```bash
flutter build web --release --base-href "/flutter_medical_demo/"
```

### 2. 进入 build/web 目录
```bash
cd build/web
```

### 3. 初始化 Git 并推送
```bash
# 删除旧的 .git（如果存在）
rm -rf .git

# 初始化新的 git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Deploy new features - $(date)"

# 创建 gh-pages 分支
git branch -M gh-pages

# 添加远程仓库（只需首次）
git remote add origin https://github.com/hughes-T/flutter_medical_demo.git

# 强制推送到 gh-pages
git push -f origin gh-pages

# 返回项目根目录
cd ../..
```

---

## 常见问题

### Q1: 每次修改代码后都需要重新 build 吗？
**A**: 是的！每次发布前必须运行 `flutter build web`，因为：
- Dart 代码需要编译成 JavaScript
- 资源文件需要打包
- 优化和压缩代码

### Q2: 如何验证部署成功？
**A**:
1. 访问：https://hughes-t.github.io/flutter_medical_demo/
2. 等待 1-3 分钟（GitHub Pages 需要时间部署）
3. 强制刷新浏览器：Ctrl + F5

### Q3: 本地开发不需要每次 build
**A**: 开发时使用热重载：
```bash
# 启动开发服务器
flutter run -d chrome

# 代码修改后按 'r' 热重载
# 或按 'R' 热重启
```

### Q4: build 失败怎么办？
**A**: 检查代码错误：
```bash
flutter analyze
```

---

## 部署流程总结

```
本地开发          发布到线上
   ↓                ↓
修改代码    →   flutter build web
   ↓                ↓
flutter run  →   git push gh-pages
   ↓                ↓
热重载测试   →   等待 1-3 分钟
                    ↓
                 在线访问
```

---

## 快捷命令

### 完整发布流程（一行命令）
```powershell
# Windows PowerShell
.\deploy.ps1

# 或者手动
flutter build web --release --base-href "/flutter_medical_demo/" && cd build/web && git init && git add . && git commit -m "Deploy" && git branch -M gh-pages && git push -f origin gh-pages && cd ../..
```

---

## 访问链接

🌐 **在线演示**: https://hughes-t.github.io/flutter_medical_demo/

📦 **GitHub 仓库**: https://github.com/hughes-T/flutter_medical_demo