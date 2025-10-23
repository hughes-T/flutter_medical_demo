import 'package:flutter/material.dart';

class TrainingTabPage extends StatelessWidget {
  const TrainingTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('训练'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 分类标签
              _buildCategoryTabs(context),
              const SizedBox(height: 16),

              // 训练模式
              Text(
                '训练模式',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              // 儿童版
              _buildModeCard(
                context,
                title: '儿童版',
                subtitle: '适合儿童的趣味训练',
                icon: Icons.child_care,
                color: const Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 12),

              // 成人版
              _buildModeCard(
                context,
                title: '成人版',
                subtitle: '专业的呼吸康复训练',
                icon: Icons.person,
                color: const Color(0xFF4A90E2),
              ),
              const SizedBox(height: 24),

              // 训练类型
              Text(
                '训练类型',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              // 训练类型列表
              _buildTrainingTypeGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    final categories = ['全部', '呼气', '吸气', '振荡', '自由'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              onSelected: (selected) {},
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingTypeGrid(BuildContext context) {
    final types = [
      {'name': '呼气训练', 'icon': Icons.air, 'color': const Color(0xFF4A90E2)},
      {'name': '吸气训练', 'icon': Icons.water_drop, 'color': const Color(0xFF50C878)},
      {'name': '振荡训练', 'icon': Icons.vibration, 'color': const Color(0xFFFF6B6B)},
      {'name': '自由训练', 'icon': Icons.fitness_center, 'color': const Color(0xFFF39C12)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types[index];
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (type['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    type['icon'] as IconData,
                    color: type['color'] as Color,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  type['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
