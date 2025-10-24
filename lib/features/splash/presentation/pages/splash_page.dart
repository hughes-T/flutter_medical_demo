import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
import '../../../../services/storage_service.dart';
import '../../../../config/dev_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _countdown = 5; // 倒计时秒数

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _startCountdown();
    _navigateToNextPage();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_countdown > 0 && mounted) {
        setState(() {
          _countdown--;
        });
        _startCountdown();
      }
    });
  }

  Future<void> _skipSplash() async {
    if (!mounted) return;

    // 初始化存储服务
    await StorageService.init();

    // 开发模式：直接跳转到首页
    if (DevConfig.shouldSkipLogin) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: DevConfig.defaultVersion,
      );
      return;
    }

    // 检查是否首次启动
    final isFirstLaunch = await StorageService.isFirstLaunch();

    if (!mounted) return;

    // 根据配置决定是否显示引导页
    if (DevConfig.shouldShowOnboarding(isFirstLaunch)) {
      // 显示引导页
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    } else {
      // 检查登录状态
      final isLoggedIn = await StorageService.isLoggedIn();
      if (!mounted) return;
      if (isLoggedIn) {
        // 已登录，跳转到首页
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        // 未登录，跳转到登录页
        Navigator.pushReplacementNamed(context, AppRoutes.loginPhone);
      }
    }
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    // 初始化存储服务
    await StorageService.init();

    // 开发模式：直接跳转到首页
    if (DevConfig.shouldSkipLogin) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: DevConfig.defaultVersion,
      );
      return;
    }

    // 检查是否首次启动
    final isFirstLaunch = await StorageService.isFirstLaunch();

    if (!mounted) return;

    // 根据配置决定是否显示引导页
    if (DevConfig.shouldShowOnboarding(isFirstLaunch)) {
      // 显示引导页
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    } else {
      // 检查登录状态
      final isLoggedIn = await StorageService.isLoggedIn();
      if (!mounted) return;
      if (isLoggedIn) {
        // 已登录，跳转到首页
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        // 未登录，跳转到登录页
        Navigator.pushReplacementNamed(context, AppRoutes.loginPhone);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 使用固定的主题色，确保在所有平台一致显示
    const primaryColor = Color(0xFF4A90E2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 主内容
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 应用图标/Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.medical_services,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 应用名称
                  const Text(
                    'Medical Training',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 副标题
                  Text(
                    '呼吸康复训练系统',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 右上角跳过按钮（带倒计时）
          SafeArea(
            child: Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: _countdown > 0 ? _skipSplash : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '跳过',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_countdown > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$_countdown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
