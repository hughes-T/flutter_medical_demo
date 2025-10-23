import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/routes.dart';
import '../../../../core/utils/validators.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  String _selectedGender = '男';

  @override
  void dispose() {
    _doctorNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 跳转到调查问卷页
    Navigator.pushNamed(
      context,
      AppRoutes.questionnaire,
      arguments: widget.version,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('录入医生处方'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                Center(
                  child: Text(
                    '请填写个人信息',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 32),

                // 姓名
                Text(
                  '姓名：患者姓名/昵称',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _doctorNameController,
                  decoration: const InputDecoration(
                    hintText: '请输入姓名',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: 24),

                // 性别
                Text(
                  '性别',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderOption('男'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildGenderOption('女'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 年龄
                Text(
                  '年龄',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: const InputDecoration(
                    hintText: '请输入年龄',
                    prefixIcon: Icon(Icons.cake_outlined),
                    suffixText: '岁',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入年龄';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 150) {
                      return '请输入有效的年龄';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 体重
                Text(
                  '体重',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                  ],
                  decoration: const InputDecoration(
                    hintText: '请输入体重',
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                    suffixText: 'kg',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入体重';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight < 1 || weight > 500) {
                      return '请输入有效的体重';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),

                // 确定按钮
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = _selectedGender == gender;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
              : Colors.grey[100],
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              gender == '男' ? Icons.male : Icons.female,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
