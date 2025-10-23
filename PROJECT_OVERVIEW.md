# 项目总览

## 项目介绍

这是一个基于 Flutter 开发的呼吸康复训练移动应用 Demo。该项目展示了完整的登录注册流程、主页框架以及基础的 UI 组件库。

## 已实现的功能模块

### 1. 启动页（Splash Screen）
**文件位置**: `lib/features/splash/presentation/pages/splash_page.dart`

**功能描述**:
- 显示应用 Logo 和名称
- 淡入动画效果
- 自动检测首次启动状态
- 自动检测登录状态
- 自动跳转到对应页面（引导页/登录页/首页）

**技术要点**:
- 使用 `AnimationController` 实现淡入动画
- 集成 `StorageService` 进行状态检测
- 使用 `Future.delayed` 控制停留时间

---

### 2. 引导页（Onboarding）
**文件位置**: `lib/features/onboarding/presentation/pages/onboarding_page.dart`

**功能描述**:
- 2个引导屏幕展示应用核心功能
- 支持左右滑动切换
- 动态页面指示器
- 跳过按钮和下一步按钮
- 最后一页显示"立即体验"按钮

**技术要点**:
- 使用 `PageView` 实现滑动切换
- 使用 `PageController` 控制页面跳转
- 动画指示器跟随页面变化
- 首次启动完成后保存状态

---

### 3. 登录注册流程

#### 3.1 手机号登录页
**文件位置**: `lib/features/auth/presentation/pages/login_phone_page.dart`

**功能描述**:
- 手机号输入（支持格式验证）
- 表单验证
- 用户协议提示
- 第三方登录入口（微信、Apple）

**技术要点**:
- 使用 `TextFormField` 实现表单输入
- 使用 `Validators` 进行输入验证
- 使用 `TextInputFormatter` 限制输入格式

#### 3.2 验证码页面
**文件位置**: `lib/features/auth/presentation/pages/login_verification_page.dart`

**功能描述**:
- 验证码输入（6位数字）
- 60秒倒计时重发功能
- 自动格式化显示手机号
- 联系客服入口

**技术要点**:
- 使用 `Timer` 实现倒计时
- 验证码输入长度限制
- 动态启用/禁用重发按钮

#### 3.3 用户信息设置页
**文件位置**: `lib/features/auth/presentation/pages/user_info_page.dart`

**功能描述**:
- 头像设置（预留功能）
- 昵称输入
- 性别选择（男/女）
- 年龄段选择（下拉菜单）
- 支持跳过

**技术要点**:
- 自定义性别选择组件
- 使用 `DropdownButtonFormField` 实现下拉选择
- 登录成功后保存 Token 和状态

---

### 4. 首页框架

#### 4.1 主页面（底部导航）
**文件位置**: `lib/features/home/presentation/pages/main_page.dart`

**功能描述**:
- 底部导航栏（首页、训练、我的）
- 使用 `IndexedStack` 保持页面状态
- 导航栏图标动态切换

#### 4.2 首页（Home Tab）
**文件位置**: `lib/features/home/presentation/pages/home_tab_page.dart`

**功能描述**:
- 欢迎横幅（渐变背景 + 快捷按钮）
- 快捷入口（训练计划、训练报告、视频课程、设备连接）
- 今日训练卡片（显示进度）
- 训练计划列表

**UI 特点**:
- 使用 `CustomScrollView` + `Sliver` 实现滚动
- 卡片式设计
- 渐变色背景
- 图标 + 文字布局

#### 4.3 训练页（Training Tab）
**文件位置**: `lib/features/home/presentation/pages/training_tab_page.dart`

**功能描述**:
- 分类标签（全部、呼气、吸气、振荡、自由）
- 训练模式选择（儿童版、成人版）
- 训练类型网格（呼气、吸气、振荡、自由）

**UI 特点**:
- 横向滚动的分类标签
- 大卡片展示训练模式
- 2列网格展示训练类型

#### 4.4 我的页（Profile Tab）
**文件位置**: `lib/features/home/presentation/pages/profile_tab_page.dart`

**功能描述**:
- 用户信息卡片（头像、昵称、手机号）
- 功能菜单（训练报告、训练计划、我的设备、我的收藏）
- 设置和帮助入口
- 退出登录功能

**技术要点**:
- 渐变色用户卡片
- 图标 + 标题的列表项
- 退出登录确认对话框
- 清除本地存储并跳转到登录页

---

## 核心模块

### 1. 应用配置
**目录**: `lib/app/`

#### 路由配置（routes.dart）
- 定义所有路由路径常量
- 实现 `onGenerateRoute` 方法
- 支持路由参数传递

#### 主题配置（theme.dart）
- 定义应用颜色方案
- 统一组件样式（按钮、输入框、卡片等）
- 文字主题配置

### 2. 核心功能
**目录**: `lib/core/`

#### 常量定义（constants/app_constants.dart）
- 应用信息
- 存储键名
- API 配置
- 验证规则常量

#### 工具类（utils/validators.dart）
- 手机号验证
- 验证码验证
- 用户名验证
- 通用非空验证

#### 通用组件（widgets/）

**CustomButton（custom_button.dart）**
- 自定义按钮组件
- 支持加载状态
- 支持实心/空心样式
- 自定义颜色和尺寸

**CustomTextField（custom_text_field.dart）**
- 自定义输入框组件
- 统一样式和验证
- 支持前缀/后缀图标
- 支持多种输入类型

**LoadingWidget（loading_widget.dart）**
- 加载指示器
- 加载遮罩层
- 可自定义消息和颜色

### 3. 服务层
**目录**: `lib/services/`

#### 存储服务（storage_service.dart）
- 封装 SharedPreferences
- 首次启动检测
- 登录状态管理
- Token 管理
- 清除数据功能

---

## 技术架构

### 状态管理
- 使用 **Riverpod** 作为状态管理方案
- 目前主要用于全局状态共享
- 为后续功能扩展预留架构

### 数据持久化
- **SharedPreferences**: 存储简单键值对（登录状态、Token等）
- **Hive**: 预留用于存储复杂数据（用户信息、训练记录等）

### 网络请求
- **Dio**: 封装 HTTP 请求
- 目前使用模拟数据
- 预留 API 接口配置

### UI 框架
- Material Design 3
- 自定义主题配置
- 响应式布局

---

## 项目特点

### 1. 代码结构清晰
- 按功能模块划分目录
- 分离 UI 层、业务逻辑层、数据层
- 便于维护和扩展

### 2. 组件复用性强
- 封装通用组件
- 统一样式管理
- 减少重复代码

### 3. 良好的用户体验
- 流畅的页面过渡动画
- 友好的错误提示
- 加载状态反馈

### 4. 易于扩展
- 清晰的路由配置
- 预留 API 接口
- 模块化设计

---

## 待扩展功能

基于原型图，以下功能可在后续版本中实现：

### 高优先级
1. **训练功能模块**
   - 儿童版训练（呼气、吸气、振荡）
   - 成人版训练
   - 训练进度追踪
   - 训练数据记录

2. **视频播放**
   - 训练视频播放
   - 课程视频播放
   - 视频进度控制

3. **设备连接**
   - 蓝牙设备搜索
   - 设备配对和连接
   - 数据实时同步

### 中等优先级
4. **数据统计**
   - 训练报告生成
   - 图表展示（使用 fl_chart）
   - 数据导出功能

5. **计划管理**
   - 创建训练计划
   - 计划提醒功能
   - 计划执行跟踪

6. **用户系统完善**
   - 头像上传
   - 个人资料编辑
   - 账号设置

### 低优先级
7. **社区功能**
   - 训练成果分享
   - 用户交流
   - 排行榜

8. **其他功能**
   - 消息通知
   - 客服系统
   - 多语言支持

---

## 开发规范

### 文件命名
- 文件名使用小写蛇形命名法（snake_case）
- 类名使用大驼峰命名法（PascalCase）
- 变量和函数使用小驼峰命名法（camelCase）

### 代码规范
- 遵循 Flutter 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 添加必要的注释

### Git 提交规范
- feat: 新功能
- fix: 修复 bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 代码重构
- test: 测试相关
- chore: 构建/工具链更新

---

## 性能优化建议

### 1. 图片优化
- 使用 `cached_network_image` 缓存网络图片
- 压缩和优化图片资源
- 使用 WebP 格式

### 2. 列表优化
- 使用 `ListView.builder` 替代 `ListView`
- 实现分页加载
- 使用 `AutomaticKeepAliveClientMixin` 保持页面状态

### 3. 动画优化
- 避免过度使用动画
- 使用 `AnimatedBuilder` 优化动画性能
- 合理使用 `const` 构造函数

### 4. 状态管理优化
- 避免不必要的 Widget 重建
- 合理划分状态作用域
- 使用 `select` 精确订阅状态变化

---

## 测试建议

### 1. 单元测试
- 测试工具类和验证器
- 测试服务层逻辑
- 测试状态管理

### 2. Widget 测试
- 测试核心组件
- 测试页面交互
- 测试路由跳转

### 3. 集成测试
- 测试完整业务流程
- 测试设备连接
- 测试数据同步

---

## 总结

这个 Demo 项目为完整的呼吸康复训练应用奠定了坚实的基础。它展示了：

- ✅ 清晰的项目结构
- ✅ 完整的登录注册流程
- ✅ 美观的 UI 设计
- ✅ 良好的代码规范
- ✅ 易于扩展的架构

后续可以基于这个框架，逐步实现训练功能、数据统计、设备连接等核心功能，最终打造一个完整的呼吸康复训练应用。

---

**作为 Java 开发者的您**，应该会发现这个项目的架构和 Spring Boot 等 Java 框架有相似之处：
- 分层架构（类似 Controller-Service-Repository）
- 依赖注入（Riverpod 类似 Spring 的 DI）
- 路由管理（类似 Spring MVC 的路由）
- 配置文件（pubspec.yaml 类似 pom.xml）

Flutter 和 Dart 的学习曲线对 Java 开发者来说比较友好，希望这个 Demo 能帮助您快速上手 Flutter 开发！
