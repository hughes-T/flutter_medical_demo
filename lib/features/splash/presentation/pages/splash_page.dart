import 'package:flutter/material.dart';
import '../../../../app/routes.dart';
import '../../../../services/storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
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

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 初始化存储服务
    await StorageService.init();

    // 检查是否首次启动
    final isFirstLaunch = await StorageService.isFirstLaunch();

    if (!mounted) return;

    if (isFirstLaunch) {
      // 首次启动，跳转到引导页
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
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
              Text(
                'Medical Training',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 8),

              // 副标题
              Text(
                '呼吸康复训练系统',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
