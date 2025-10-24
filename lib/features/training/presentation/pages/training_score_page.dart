import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../home/presentation/pages/main_page.dart';

class TrainingScorePage extends StatefulWidget {
  final String version; // 儿童版 或 成人版
  final String trainingType; // 训练类型
  final int score; // 得分
  final int duration; // 训练时长（秒）
  final Map<String, dynamic>? extraData; // 额外数据

  const TrainingScorePage({
    super.key,
    required this.version,
    required this.trainingType,
    required this.score,
    required this.duration,
    this.extraData,
  });

  @override
  State<TrainingScorePage> createState() => _TrainingScorePageState();
}

class _TrainingScorePageState extends State<TrainingScorePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scoreAnimation = Tween<double>(begin: 0, end: widget.score.toDouble()).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  Color get _primaryColor {
    if (widget.trainingType == '呼气训练') return const Color(0xFF4FC3F7);
    if (widget.trainingType == '吸气训练') return const Color(0xFF66BB6A);
    return const Color(0xFFFF6B6B);
  }

  String get _emoji {
    if (widget.score >= 90) return '🎉';
    if (widget.score >= 80) return '😊';
    if (widget.score >= 70) return '👍';
    if (widget.score >= 60) return '💪';
    return '😅';
  }

  String get _encouragement {
    final isChild = widget.version == '儿童版';
    if (widget.score >= 90) {
      return isChild ? '太棒了！你真是个小超人！' : '优秀！继续保持！';
    } else if (widget.score >= 80) {
      return isChild ? '真不错！继续加油哦！' : '很好，继续努力！';
    } else if (widget.score >= 70) {
      return isChild ? '做得很好！下次会更棒！' : '良好，还有提升空间！';
    } else if (widget.score >= 60) {
      return isChild ? '加油！你可以做得更好！' : '及格，需要更多练习！';
    } else {
      return isChild ? '别灰心，再试一次吧！' : '需要加强训练！';
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes分$secs秒';
  }

  @override
  Widget build(BuildContext context) {
    final isChild = widget.version == '儿童版';

    return Scaffold(
      backgroundColor: isChild ? const Color(0xFFFFF9E6) : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部装饰条
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryColor, _primaryColor.withValues(alpha: 0.6)],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // 分数展示区域
                      _buildScoreDisplay(isChild),

                      const SizedBox(height: 32),

                      // 鼓励文字
                      _buildEncouragementText(isChild),

                      const SizedBox(height: 32),

                      // 训练数据展示
                      _buildTrainingStats(isChild),

                      const SizedBox(height: 32),

                      // 按钮组
                      _buildActionButtons(isChild),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 分数展示
  Widget _buildScoreDisplay(bool isChild) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: isChild
                  ? RadialGradient(
                      colors: [
                        _primaryColor.withValues(alpha: 0.1),
                        Colors.white,
                      ],
                    )
                  : null,
              color: isChild ? null : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _primaryColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // 装饰性圆环
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // 外圈装饰
                    if (isChild)
                      Transform.rotate(
                        angle: _rotateAnimation.value * 2 * math.pi,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _primaryColor.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: List.generate(
                              8,
                              (index) => Transform.rotate(
                                angle: (index * math.pi / 4),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // 分数显示
                    Column(
                      children: [
                        if (isChild)
                          Text(
                            _emoji,
                            style: const TextStyle(fontSize: 60),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _scoreAnimation.value.toInt().toString(),
                              style: TextStyle(
                                fontSize: isChild ? 80 : 72,
                                fontWeight: FontWeight.bold,
                                color: _primaryColor,
                                height: 1.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '分',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: _primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!isChild) const SizedBox(height: 8),
                        if (!isChild)
                          Text(
                            _emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 训练类型标签
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: _primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    widget.trainingType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 鼓励文字
  Widget _buildEncouragementText(bool isChild) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.value,
          child: Column(
            children: [
              if (isChild)
                Text(
                  '您本次的训练得分为${widget.score}分！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _primaryColor.withValues(alpha: 0.1),
                      _primaryColor.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isChild)
                      const Text(
                        '🌟 ',
                        style: TextStyle(fontSize: 24),
                      ),
                    Flexible(
                      child: Text(
                        _encouragement,
                        style: TextStyle(
                          fontSize: isChild ? 18 : 16,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              if (isChild) ...[
                const SizedBox(height: 12),
                Text(
                  '继续加油！',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // 训练数据统计
  Widget _buildTrainingStats(bool isChild) {
    final stats = [
      {
        'icon': Icons.timer_outlined,
        'label': '训练时长',
        'value': _formatDuration(widget.duration),
        'emoji': '⏱️',
      },
      {
        'icon': Icons.fitness_center,
        'label': '完成度',
        'value': '${((widget.score / 100) * 100).toInt()}%',
        'emoji': '💯',
      },
      {
        'icon': Icons.trending_up,
        'label': '难度等级',
        'value': widget.score >= 80 ? '标准' : '基础',
        'emoji': '📈',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (isChild)
                const Text(
                  '📊 ',
                  style: TextStyle(fontSize: 20),
                ),
              Text(
                '训练数据',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...stats.map((stat) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    if (isChild)
                      Text(
                        stat['emoji'] as String,
                        style: const TextStyle(fontSize: 24),
                      )
                    else
                      Icon(
                        stat['icon'] as IconData,
                        color: _primaryColor,
                        size: 24,
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        stat['label'] as String,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Text(
                      stat['value'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // 操作按钮
  Widget _buildActionButtons(bool isChild) {
    return Column(
      children: [
        // 查看报告按钮
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // 返回到主页面并切换到报告 tab（索引为2）
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    version: widget.version,
                    initialTabIndex: 2, // 报告页的索引
                  ),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              elevation: 8,
              shadowColor: _primaryColor.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isChild)
                  const Text(
                    '📋 ',
                    style: TextStyle(fontSize: 24),
                  ),
                const Text(
                  '查看报告',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // 关闭按钮
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              // 返回到主页面的首页 tab
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    version: widget.version,
                    initialTabIndex: 0, // 首页的索引
                  ),
                ),
                (route) => false,
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[400]!, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Text(
              '关闭',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
