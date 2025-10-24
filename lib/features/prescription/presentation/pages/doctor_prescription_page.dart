import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/routes.dart';

class DoctorPrescriptionPage extends StatefulWidget {
  final String version;

  const DoctorPrescriptionPage({
    super.key,
    required this.version,
  });

  @override
  State<DoctorPrescriptionPage> createState() => _DoctorPrescriptionPageState();
}

class _DoctorPrescriptionPageState extends State<DoctorPrescriptionPage> {
  // 当前选中的Tab: 0-录入医生处方, 1-填写评估问卷
  int _selectedTab = 0;

  // 训练模式
  String _trainingMode = '呼气训练';
  final List<String> _trainingModes = ['呼气训练', '吸气训练', '振荡排痰'];

  // 训练模式图标映射
  final Map<String, IconData> _trainingIcons = {
    '呼气训练': Icons.air,
    '吸气训练': Icons.water_drop,
    '振荡排痰': Icons.vibration,
  };

  // 训练模式颜色映射
  final Map<String, Color> _trainingColors = {
    '呼气训练': Color(0xFF4FC3F7),
    '吸气训练': Color(0xFF66BB6A),
    '振荡排痰': Color(0xFFFF6B6B),
  };

  // 训练挡位
  int _trainingLevel = 6;

  // 训练次数
  int _trainingCount = 1;

  @override
  void dispose() {
    super.dispose();
  }

  void _onConfirm() {
    // 跳转到调查问卷页
    Navigator.pushNamed(
      context,
      AppRoutes.questionnaire,
      arguments: widget.version,
    );
  }

  void _onSkip() {
    // 跳过，直接进入首页
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
      arguments: widget.version,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('录入医生处方'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // 跳过按钮
          TextButton(
            onPressed: _onSkip,
            child: const Text(
              '跳过',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部Tab切换
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFF5F5F5),
              child: Row(
                children: [
                  Expanded(
                    child: _buildEnhancedTabButton(
                      title: '录入医生处方',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildEnhancedTabButton(
                      title: '填写评估问卷',
                      isSelected: _selectedTab == 1,
                      onTap: () {
                        // 直接跳转到问卷页面
                        Navigator.pushNamed(
                          context,
                          AppRoutes.questionnaire,
                          arguments: widget.version,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 内容区域
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 训练模式
                    _buildEnhancedSectionTitle('训练模式', Icons.fitness_center),
                    const SizedBox(height: 12),
                    _buildEnhancedTrainingModeSelector(),
                    const SizedBox(height: 24),

                    // 训练挡位
                    _buildEnhancedSectionTitle('训练挡位', Icons.settings),
                    const SizedBox(height: 12),
                    _buildEnhancedTrainingLevelSelector(),
                    const SizedBox(height: 8),
                    _buildLevelIndicator(),
                    const SizedBox(height: 24),

                    // 训练次数
                    _buildEnhancedSectionTitle('训练次数', Icons.repeat),
                    const SizedBox(height: 12),
                    _buildEnhancedTrainingCountInput(),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        '(建议: 1-10次)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // 确定按钮
                    _buildEnhancedConfirmButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 增强版Tab按钮 - 卡片式设计
  Widget _buildEnhancedTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF0288D1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color(0xFF4FC3F7).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 增强版节标题 - 带图标
  Widget _buildEnhancedSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF4FC3F7)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // 增强版训练模式选择器 - 带图标的卡片式
  Widget _buildEnhancedTrainingModeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: _trainingColors[_trainingMode]!.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _trainingMode,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          icon: Icon(
            Icons.arrow_drop_down,
            color: _trainingColors[_trainingMode],
            size: 28,
          ),
          items: _trainingModes.map((mode) {
            return DropdownMenuItem<String>(
              value: mode,
              child: Row(
                children: [
                  Icon(
                    _trainingIcons[mode],
                    color: _trainingColors[mode],
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    mode,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _trainingMode = value;
              });
            }
          },
        ),
      ),
    );
  }

  // 增强版训练挡位选择器 - 步进器设计
  Widget _buildEnhancedTrainingLevelSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 减号按钮
          _buildCircleButton(
            icon: Icons.remove,
            onPressed: _trainingLevel > 1
                ? () {
                    setState(() {
                      _trainingLevel--;
                    });
                  }
                : null,
          ),
          const SizedBox(width: 24),
          // 中间数字显示
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE1F5FE),
                  Color(0xFFB3E5FC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF4FC3F7),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                _trainingLevel.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0288D1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // 加号按钮
          _buildCircleButton(
            icon: Icons.add,
            onPressed: _trainingLevel < 10
                ? () {
                    setState(() {
                      _trainingLevel++;
                    });
                  }
                : null,
          ),
          const SizedBox(width: 16),
          // 下拉菜单
          PopupMenuButton<int>(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF4FC3F7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF4FC3F7),
              ),
            ),
            onSelected: (value) {
              setState(() {
                _trainingLevel = value;
              });
            },
            itemBuilder: (context) {
              return List.generate(10, (index) {
                final level = index + 1;
                return PopupMenuItem<int>(
                  value: level,
                  child: Text('挡位 $level'),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  // 挡位刻度指示器
  Widget _buildLevelIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(10, (index) {
          final level = index + 1;
          final isActive = level <= _trainingLevel;
          return Expanded(
            child: Column(
              children: [
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Color(0xFF4FC3F7)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 4),
                if (level == 1 || level == 5 || level == 10)
                  Text(
                    level.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? Color(0xFF4FC3F7) : Colors.grey,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // 增强版训练次数输入 - 步进器设计
  Widget _buildEnhancedTrainingCountInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 减号按钮
          _buildCircleButton(
            icon: Icons.remove,
            onPressed: _trainingCount > 1
                ? () {
                    setState(() {
                      _trainingCount--;
                    });
                  }
                : null,
          ),
          const SizedBox(width: 32),
          // 中间数字显示（可编辑）
          SizedBox(
            width: 100,
            child: TextField(
              controller: TextEditingController(text: _trainingCount.toString()),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0288D1),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '1',
                hintStyle: TextStyle(
                  fontSize: 32,
                  color: Colors.grey[400],
                ),
              ),
              onChanged: (value) {
                final count = int.tryParse(value);
                if (count != null && count >= 1 && count <= 99) {
                  setState(() {
                    _trainingCount = count;
                  });
                }
              },
            ),
          ),
          const SizedBox(width: 32),
          // 加号按钮
          _buildCircleButton(
            icon: Icons.add,
            onPressed: () {
              setState(() {
                _trainingCount++;
              });
            },
          ),
        ],
      ),
    );
  }

  // 圆形按钮组件
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: onPressed != null
              ? LinearGradient(
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF0288D1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: onPressed == null ? Colors.grey[300] : null,
          borderRadius: BorderRadius.circular(24),
          boxShadow: onPressed != null
              ? [
                  BoxShadow(
                    color: Color(0xFF4FC3F7).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  // 增强版确定按钮 - 渐变色设计
  Widget _buildEnhancedConfirmButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF0288D1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4FC3F7).withValues(alpha: 0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onConfirm,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '确定并继续',
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
      ),
    );
  }
}
