import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

// 训练数据指标模型
class TrainingMetric {
  final String name;        // 指标名称
  final String value;       // 数值
  final String unit;        // 单位
  final IconData? icon;     // 图标（可选）

  TrainingMetric({
    required this.name,
    required this.value,
    required this.unit,
    this.icon,
  });
}

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
  bool _isDeviceConnected = false; // 设备连接状态

  // 训练数据指标（模拟数据，后期对接真实API）
  final Map<String, List<TrainingMetric>> _trainingMetrics = {
    '呼气训练': [
      TrainingMetric(
        name: '呼气量',
        value: '1250',
        unit: 'ml',
        icon: Icons.air,
      ),
      TrainingMetric(
        name: '最大峰流速',
        value: '450',
        unit: 'L/min',
        icon: Icons.trending_up,
      ),
      TrainingMetric(
        name: 'FEV1',
        value: '2.8',
        unit: 'L',
        icon: Icons.timer,
      ),
      TrainingMetric(
        name: '肺活量',
        value: '3.5',
        unit: 'L',
        icon: Icons.favorite,
      ),
    ],
    '吸气训练': [
      TrainingMetric(
        name: '吸气量',
        value: '1100',
        unit: 'ml',
        icon: Icons.water_drop,
      ),
      TrainingMetric(
        name: '最大峰流速',
        value: '380',
        unit: 'L/min',
        icon: Icons.trending_up,
      ),
      TrainingMetric(
        name: '用力吸气值',
        value: '2.5',
        unit: 'L',
        icon: Icons.timer,
      ),
      TrainingMetric(
        name: '肺活量',
        value: '3.5',
        unit: 'L',
        icon: Icons.favorite,
      ),
    ],
    '振荡排痰': [
      TrainingMetric(
        name: '最大频率',
        value: '25',
        unit: 'Hz',
        icon: Icons.arrow_upward,
      ),
      TrainingMetric(
        name: '最小频率',
        value: '10',
        unit: 'Hz',
        icon: Icons.arrow_downward,
      ),
      TrainingMetric(
        name: '最大压力',
        value: '35',
        unit: 'cmH₂O',
        icon: Icons.expand_less,
      ),
      TrainingMetric(
        name: '最小压力',
        value: '15',
        unit: 'cmH₂O',
        icon: Icons.expand_more,
      ),
    ],
  };

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
    // 检查设备连接状态
    if (!_isDeviceConnected) {
      _showDeviceNotConnectedDialog();
      return;
    }

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

  // 显示设备未连接提示对话框
  void _showDeviceNotConnectedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[700],
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text(
                '设备未连接',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            '请先连接设备后再开始训练',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // 跳转到设备连接页面（不显示跳过按钮）
                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.deviceConnection,
                  arguments: false, // 不显示跳过按钮
                );

                // 如果返回值为 true，表示连接成功
                if (result == true && mounted) {
                  setState(() {
                    _isDeviceConnected = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text(
                '确定',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 跳转到设备连接页面
  void _navigateToDeviceConnection() async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.deviceConnection,
      arguments: false, // 不显示跳过按钮
    );

    // 如果返回值为 true，表示连接成功
    if (result == true && mounted) {
      setState(() {
        _isDeviceConnected = true;
      });
    }
  }

  // 构建单个数据指标卡片
  Widget _buildMetricCard(TrainingMetric metric) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          if (metric.icon != null)
            Icon(
              metric.icon,
              color: Colors.grey[600],
              size: 12,
            ),
          if (metric.icon != null) const SizedBox(height: 1),

          // 指标名称
          Text(
            metric.name,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),

          // 数值
          Text(
            metric.value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          // 单位
          Text(
            metric.unit,
            style: TextStyle(
              fontSize: 8,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // 构建数据指标网格
  Widget _buildMetricsGrid() {
    final metrics = _trainingMetrics[_selectedTraining] ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 1.4,
        ),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          return _buildMetricCard(metrics[index]);
        },
      ),
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
            // 顶部：版本展示 + 设备连接状态
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左侧：版本展示
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      borderRadius: BorderRadius.circular(20),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.version,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 14),
                        ),
                      ],
                    ),
                  ),

                  // 右侧：设备连接状态
                  GestureDetector(
                    onTap: _navigateToDeviceConnection,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: _isDeviceConnected
                            ? const Color(0xFF66BB6A).withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isDeviceConnected
                              ? const Color(0xFF66BB6A)
                              : Colors.red,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _isDeviceConnected
                                  ? const Color(0xFF66BB6A)
                                  : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isDeviceConnected ? '已连接' : '未连接',
                            style: TextStyle(
                              color: _isDeviceConnected
                                  ? const Color(0xFF66BB6A)
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.bluetooth,
                            size: 16,
                            color: _isDeviceConnected
                                ? const Color(0xFF66BB6A)
                                : Colors.red,
                          ),
                        ],
                      ),
                    ),
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
                              child: Icon(
                                module.icon,
                                size: isSelected ? 38 : 32,
                                color: isSelected ? module.color : Colors.grey,
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
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                padding: const EdgeInsets.all(16),
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
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    // 训练图标和名称（横向布局）
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .icon,
                            size: 24,
                            color: _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectedTraining,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _trainingModules
                                .firstWhere((m) => m.name == _selectedTraining)
                                .color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 数据指标网格
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Container(
                          key: ValueKey(_selectedTraining),
                          child: _buildMetricsGrid(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
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
                  child: const Text(
                    '开始训练',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
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
