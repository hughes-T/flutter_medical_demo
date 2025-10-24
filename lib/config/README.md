# 开发配置说明

## 文件位置
`lib/config/dev_config.dart`

## 使用场景

### 场景 1: 开发模式 - 跳过登录直接进入首页（默认配置）
```dart
class DevConfig {
  static const bool isDevelopmentMode = true;   // 开启开发模式
  static const bool forceShowOnboarding = false; // 不显示引导页
  static const bool skipLogin = true;            // 跳过登录
  static const String defaultVersion = '儿童版';  // 默认进入儿童版
}
```
**效果**: 刷新浏览器后，等待 5 秒倒计时（或点击"跳过"），直接进入儿童版首页。

### 场景 2: 开发模式 - 测试引导页流程
```dart
class DevConfig {
  static const bool isDevelopmentMode = true;   // 开启开发模式
  static const bool forceShowOnboarding = true;  // 强制显示引导页
  static const bool skipLogin = false;           // 不跳过登录
  static const String defaultVersion = '儿童版';
}
```
**效果**: 刷新浏览器后，会显示引导页，可以测试引导页的交互流程。

### 场景 3: 开发模式 - 测试登录流程
```dart
class DevConfig {
  static const bool isDevelopmentMode = true;   // 开启开发模式
  static const bool forceShowOnboarding = false; // 不显示引导页
  static const bool skipLogin = false;           // 不跳过登录
  static const String defaultVersion = '儿童版';
}
```
**效果**: 刷新浏览器后，如果未登录会显示登录页，可以测试登录流程。

### 场景 4: 生产模式 - 正常用户流程
```dart
class DevConfig {
  static const bool isDevelopmentMode = false;  // 关闭开发模式
  static const bool forceShowOnboarding = false;
  static const bool skipLogin = false;
  static const String defaultVersion = '儿童版';
}
```
**效果**: 正常的生产环境行为
- 首次访问：显示引导页
- 已访问过但未登录：显示登录页
- 已登录：进入首页

### 场景 5: 进入成人版首页
```dart
class DevConfig {
  static const bool isDevelopmentMode = true;
  static const bool forceShowOnboarding = false;
  static const bool skipLogin = true;
  static const String defaultVersion = '成人版';  // 修改为成人版
}
```
**效果**: 刷新浏览器后，直接进入成人版首页。

## 配置参数说明

| 参数 | 类型 | 说明 | 可选值 |
|-----|------|------|--------|
| `isDevelopmentMode` | bool | 是否为开发模式 | `true` / `false` |
| `forceShowOnboarding` | bool | 是否强制显示引导页（仅开发模式有效） | `true` / `false` |
| `skipLogin` | bool | 是否跳过登录（仅开发模式有效） | `true` / `false` |
| `defaultVersion` | String | 默认版本（跳过登录时使用） | `'儿童版'` / `'成人版'` |

## 优先级规则

1. **生产模式** (`isDevelopmentMode = false`)
   - 所有其他配置无效
   - 完全按照正常用户流程运行

2. **开发模式 + 跳过登录** (`isDevelopmentMode = true && skipLogin = true`)
   - 优先级最高
   - 直接进入 `defaultVersion` 指定的首页
   - `forceShowOnboarding` 无效

3. **开发模式 + 不跳过登录** (`isDevelopmentMode = true && skipLogin = false`)
   - 根据 `forceShowOnboarding` 决定是否显示引导页
   - 之后按照正常登录流程

## 快速切换

### 日常开发（推荐）
```dart
static const bool isDevelopmentMode = true;
static const bool skipLogin = true;
static const String defaultVersion = '儿童版'; // 根据需要切换
```

### 发布前测试
```dart
static const bool isDevelopmentMode = false; // 切换为生产模式即可
```

### 测试引导页
```dart
static const bool isDevelopmentMode = true;
static const bool forceShowOnboarding = true;
static const bool skipLogin = false;
```

## 调试信息

在开发模式下，`DevConfig.modeDescription` 会返回当前配置的描述信息，可以在调试时使用：

```dart
debugPrint('当前模式: ${DevConfig.modeDescription}');
```

输出示例：
- `"开发模式 - 跳过登录直接进入儿童版首页"`
- `"开发模式 - 显示引导页"`
- `"开发模式 - 显示登录页"`
- `"生产模式"`
