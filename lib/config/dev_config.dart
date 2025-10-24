/// 开发配置
///
/// 此文件用于控制应用在开发、测试、生产环境下的行为
///
/// 使用方式：
/// 1. 开发模式：设置 isDevelopmentMode = true，可跳过登录直接进入首页
/// 2. 测试引导页：设置 forceShowOnboarding = true，可查看引导页流程
/// 3. 生产模式：设置 isDevelopmentMode = false，正常登录流程
class DevConfig {
  /// 是否为开发模式
  ///
  /// true: 开发模式，可以跳过登录等操作
  /// false: 生产模式，正常流程
  static const bool isDevelopmentMode = false;

  /// 是否强制显示引导页（仅在开发模式下生效）
  ///
  /// true: 即使在开发模式下，也显示引导页
  /// false: 跳过引导页
  static const bool forceShowOnboarding = true;

  /// 是否跳过登录（仅在开发模式下生效）
  ///
  /// true: 跳过登录，直接进入首页
  /// false: 显示登录页面
  static const bool skipLogin = false;

  /// 默认版本（仅在跳过登录时使用）
  ///
  /// '儿童版' 或 '成人版'
  static const String defaultVersion = '儿童版';

  /// 开发模式提示
  ///
  /// 返回当前配置的描述信息
  static String get modeDescription {
    if (!isDevelopmentMode) {
      return '生产模式';
    }

    if (forceShowOnboarding) {
      return '开发模式 - 显示引导页';
    }

    if (skipLogin) {
      return '开发模式 - 跳过登录直接进入$defaultVersion首页';
    }

    return '开发模式 - 显示登录页';
  }

  /// 是否应该显示引导页
  static bool shouldShowOnboarding(bool isFirstLaunch) {
    // 生产模式：根据实际的 firstLaunch 状态决定
    if (!isDevelopmentMode) {
      return isFirstLaunch;
    }

    // 开发模式：根据 forceShowOnboarding 配置决定
    return forceShowOnboarding;
  }

  /// 是否应该跳过登录
  static bool get shouldSkipLogin {
    return isDevelopmentMode && skipLogin;
  }
}
