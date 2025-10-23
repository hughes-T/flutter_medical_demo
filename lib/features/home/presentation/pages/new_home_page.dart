import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class NewHomePage extends StatefulWidget {
  final String version; // 儿童版 或 成人版

  const NewHomePage({
    super.key,
    this.version = '儿童版',
  });

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  String _selectedTraining = '呼气训练';

  final List<TrainingModule> _trainingModules = [
    TrainingModule(name: '呼气训练', icon: Icons.air, color: Color(0xFF4FC3F7)),
    TrainingModule(name: '吸气训练', icon: Icons.water_drop, color: Color(0xFF66BB6A)),
    TrainingModule(name: '振荡排痰', icon: Icons.vibration, color: Color(0xFFFF6B6B)),
  ];

  void _startTraining() {
    // 跳转到对应的训练页面
    Navigator.pushNamed(
      context,
      AppRoutes.training,
      arguments: {
        'version': widget.version,
        'type': _selectedTraining,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isChildVersion = widget.version == '儿童版';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部版本提示
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: isChildVersion ? const Color(0xFF4FC3F7) : const Color(0xFF66BB6A),
              child: Column(
                children: [
                  Text(
                    '仅限本用户当前使用版本：',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.version,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle, color: Colors.white, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '未选择，则不可以使用相关功能，\n不可切换。\n引导用户选择版本',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '没备选版本会\n只显示选择的版本',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            // 训练模块选择
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _trainingModules.map((module) {
                  final isSelected = _selectedTraining == module.name;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTraining = module.name;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? module.color.withValues(alpha: 0.2)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? module.color : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            module.icon,
                            color: isSelected ? module.color : Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          module.name,
                          style: TextStyle(
                            color: isSelected ? module.color : Colors.grey[600],
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // 用户名称区域
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '用户名称',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: 切换用户
                    },
                    child: const Text('切换'),
                  ),
                ],
              ),
            ),

            // 主内容区域
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _trainingModules
                            .firstWhere((m) => m.name == _selectedTraining)
                            .icon,
                        size: 80,
                        color: _trainingModules
                            .firstWhere((m) => m.name == _selectedTraining)
                            .color,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _selectedTraining,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isChildVersion ? '准备好了吗？让我们开始有趣的训练吧！' : '准备开始专业的呼吸训练',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 开始训练按钮
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _startTraining,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isChildVersion
                        ? const Color(0xFF4FC3F7)
                        : const Color(0xFF66BB6A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '开始训练',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 底部提示
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '如何进行${_selectedTraining}？',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: 播放语音说明
                    },
                    icon: const Icon(Icons.play_circle_outline, size: 20),
                    label: const Text('语音播（点击播放）'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class TrainingModule {
  final String name;
  final IconData icon;
  final Color color;

  TrainingModule({
    required this.name,
    required this.icon,
    required this.color,
  });
}
