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
    TrainingModule(
      name: '呼气训练',
      icon: Icons.air,
      color: Color(0xFF4FC3F7),
      emoji: '💨',
      description: '呼～让我们一起吹泡泡！',
    ),
    TrainingModule(
      name: '吸气训练',
      icon: Icons.water_drop,
      color: Color(0xFF66BB6A),
      emoji: '💧',
      description: '深呼吸，像闻花香一样～',
    ),
    TrainingModule(
      name: '振荡排痰',
      icon: Icons.vibration,
      color: Color(0xFFFF6B6B),
      emoji: '🎵',
      description: '一起摇摆，轻松排痰！',
    ),
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
            // 顶部版本横幅
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                gradient: isChildVersion
                    ? const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: (isChildVersion ? const Color(0xFF4FC3F7) : const Color(0xFF66BB6A))
                        .withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isChildVersion) const Text('🎈 ', style: TextStyle(fontSize: 24)),
                  Text(
                    widget.version,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),

            // 训练模块选择
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Column(
                        children: [
                          Container(
                            width: isSelected ? 70 : 64,
                            height: isSelected ? 70 : 64,
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      colors: [
                                        module.color.withValues(alpha: 0.3),
                                        module.color.withValues(alpha: 0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: !isSelected ? Colors.grey[100] : null,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? module.color : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: module.color.withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                isChildVersion ? module.emoji : '',
                                style: TextStyle(fontSize: isSelected ? 38 : 32),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            module.name,
                            style: TextStyle(
                              color: isSelected ? module.color : Colors.grey[700],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: isSelected ? 15 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // 用户名称区域
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  if (isChildVersion)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF4FC3F7),
                        size: 24,
                      ),
                    ),
                  if (isChildVersion) const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isChildVersion)
                        Text(
                          '小朋友',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      const Text(
                        '用户名称',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 主内容区域
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _trainingModules
                          .firstWhere((m) => m.name == _selectedTraining)
                          .color
                          .withValues(alpha: 0.05),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _trainingModules
                        .firstWhere((m) => m.name == _selectedTraining)
                        .color
                        .withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _trainingModules
                          .firstWhere((m) => m.name == _selectedTraining)
                          .color
                          .withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Emoji 或 Icon
                      if (isChildVersion)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .emoji,
                            style: const TextStyle(fontSize: 80),
                          ),
                        )
                      else
                        Icon(
                          _trainingModules
                              .firstWhere((m) => m.name == _selectedTraining)
                              .icon,
                          size: 80,
                          color: _trainingModules
                              .firstWhere((m) => m.name == _selectedTraining)
                              .color,
                        ),
                      const SizedBox(height: 32),
                      Text(
                        _selectedTraining,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _trainingModules
                              .firstWhere((m) => m.name == _selectedTraining)
                              .color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: _trainingModules
                              .firstWhere((m) => m.name == _selectedTraining)
                              .color
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isChildVersion
                              ? _trainingModules
                                  .firstWhere((m) => m.name == _selectedTraining)
                                  .description
                              : '准备开始专业的呼吸训练',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
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
                height: 60,
                child: ElevatedButton(
                  onPressed: _startTraining,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _trainingModules
                        .firstWhere((m) => m.name == _selectedTraining)
                        .color,
                    elevation: 8,
                    shadowColor: _trainingModules
                        .firstWhere((m) => m.name == _selectedTraining)
                        .color
                        .withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isChildVersion)
                        const Text(
                          '🚀 ',
                          style: TextStyle(fontSize: 24),
                        ),
                      const Text(
                        '开始训练',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 底部提示
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '如何进行${_selectedTraining}？',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color,
                            _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color
                                .withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_circle_outline, size: 18, color: Colors.white),
                          const SizedBox(width: 4),
                          const Text(
                            '语音播',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
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
  final String emoji;
  final String description;

  TrainingModule({
    required this.name,
    required this.icon,
    required this.color,
    required this.emoji,
    required this.description,
  });
}
