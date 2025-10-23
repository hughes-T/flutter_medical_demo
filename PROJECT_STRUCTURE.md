# 项目文件结构

```
flutter_medical_demo/
│
├── lib/                                          # 源代码目录
│   ├── main.dart                                # 应用入口文件
│   │
│   ├── app/                                     # 应用配置
│   │   ├── routes.dart                         # 路由配置
│   │   └── theme.dart                          # 主题配置
│   │
│   ├── core/                                    # 核心功能模块
│   │   ├── constants/                          # 常量定义
│   │   │   └── app_constants.dart             # 应用常量
│   │   │
│   │   ├── utils/                              # 工具类
│   │   │   └── validators.dart                # 表单验证工具
│   │   │
│   │   └── widgets/                            # 通用组件
│   │       ├── custom_button.dart             # 自定义按钮
│   │       ├── custom_text_field.dart         # 自定义输入框
│   │       └── loading_widget.dart            # 加载组件
│   │
│   ├── features/                                # 功能模块
│   │   │
│   │   ├── splash/                             # 启动页模块
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── splash_page.dart       # 启动页
│   │   │
│   │   ├── onboarding/                         # 引导页模块
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── onboarding_page.dart   # 引导页
│   │   │
│   │   ├── auth/                               # 认证模块
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           ├── login_phone_page.dart           # 手机号登录页
│   │   │           ├── login_verification_page.dart    # 验证码页
│   │   │           └── user_info_page.dart             # 用户信息设置页
│   │   │
│   │   └── home/                               # 首页模块
│   │       └── presentation/
│   │           └── pages/
│   │               ├── main_page.dart          # 主页面（带底部导航）
│   │               ├── home_tab_page.dart      # 首页 Tab
│   │               ├── training_tab_page.dart  # 训练 Tab
│   │               └── profile_tab_page.dart   # 我的 Tab
│   │
│   └── services/                                # 服务层
│       └── storage_service.dart                # 本地存储服务
│
├── android/                                     # Android 平台相关文件
├── ios/                                         # iOS 平台相关文件
├── web/                                         # Web 平台相关文件
├── test/                                        # 测试文件目录
│
├── pubspec.yaml                                 # 项目配置和依赖管理
├── analysis_options.yaml                        # 代码分析配置
├── .gitignore                                   # Git 忽略文件配置
│
├── README.md                                    # 项目说明文档
├── QUICK_START.md                               # 快速启动指南
├── PROJECT_OVERVIEW.md                          # 项目总览
└── PROJECT_STRUCTURE.md                         # 项目结构说明（本文件）
```

## 目录说明

### `/lib` - 源代码主目录

#### `/lib/app` - 应用配置
存放应用级别的配置，如路由、主题等。

#### `/lib/core` - 核心功能
存放项目中可复用的核心功能：
- **constants**: 应用中使用的常量
- **utils**: 工具类和辅助函数
- **widgets**: 通用 UI 组件

#### `/lib/features` - 功能模块
按功能划分的业务模块，每个模块采用清晰的分层结构：
- **presentation**: 表现层（UI 页面和组件）
- **providers**: 状态管理（预留）
- **models**: 数据模型（预留）

#### `/lib/services` - 服务层
存放各种服务类，如网络请求、本地存储、设备通信等。

### 平台相关目录
- `/android`: Android 平台特定配置和代码
- `/ios`: iOS 平台特定配置和代码
- `/web`: Web 平台特定配置和代码

### 配置文件
- **pubspec.yaml**: Flutter 项目配置文件，包含依赖管理、资源配置等
- **analysis_options.yaml**: Dart 代码分析规则配置
- **.gitignore**: Git 版本控制忽略规则

## 文件统计

- **Dart 源文件**: 19 个
- **配置文件**: 3 个
- **文档文件**: 4 个

## 代码行数（约）

- main.dart: ~30 行
- 路由和主题: ~250 行
- 核心功能: ~200 行
- 启动和引导页: ~300 行
- 登录流程: ~600 行
- 首页模块: ~600 行

**总计约 2000 行代码**

## 扩展建议

未来可以按照以下结构扩展新功能：

```
lib/features/training/              # 训练功能模块
├── data/                          # 数据层
│   ├── models/                    # 数据模型
│   ├── repositories/              # 数据仓库
│   └── datasources/               # 数据源
├── domain/                        # 业务逻辑层
│   ├── entities/                  # 实体
│   └── usecases/                  # 用例
└── presentation/                  # 表现层
    ├── pages/                     # 页面
    ├── widgets/                   # 组件
    └── providers/                 # 状态管理
```

这种分层架构便于：
- 代码维护和测试
- 团队协作开发
- 功能模块化管理
