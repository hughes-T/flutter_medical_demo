import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class VersionSelectionPage extends StatelessWidget {
  const VersionSelectionPage({super.key});

  void _selectVersion(BuildContext context, String version) {
    // 跳转到医生处方录入页
    Navigator.pushNamed(
      context,
      AppRoutes.doctorPrescription,
      arguments: version,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // 标题
              Text(
                '请选择您要使用的版本',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // 版本选择卡片
              Row(
                children: [
                  // 儿童版
                  Expanded(
                    child: _buildVersionCard(
                      context,
                      version: '儿童版',
                      color: const Color(0xFF4FC3F7),
                      icon: Icons.child_care,
                      onTap: () => _selectVersion(context, '儿童版'),
                    ),
                  ),
                  const SizedBox(width: 24),

                  // 成人版
                  Expanded(
                    child: _buildVersionCard(
                      context,
                      version: '成人版',
                      color: const Color(0xFF66BB6A),
                      icon: Icons.person,
                      onTap: () => _selectVersion(context, '成人版'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 提示文字
              Text(
                '儿童版包含趣味引导等趣味添加趣味素图',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersionCard(
    BuildContext context, {
    required String version,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              version,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
