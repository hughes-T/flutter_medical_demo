# 医生处方页面重新设计

## ✅ 完成的修改

### 修改文件
`lib/features/prescription/presentation/pages/doctor_prescription_page.dart`

---

## 🎨 新设计特点

### 1. **顶部导航栏**
- ✅ AppBar 右上角添加"跳过"按钮
- ✅ 点击跳过直接进入首页（跳过问卷）

### 2. **Tab 切换区域**
- ✅ 左侧：录入医生处方（蓝色高亮）
- ✅ 右侧：填写评估问卷（灰色）
- ✅ 可点击切换（当前只实现了医生处方Tab的内容）

### 3. **训练设置表单**

#### 训练模式
- ✅ 下拉选择框（DropdownButton）
- ✅ 选项：呼气训练、吸气训练、振荡排痰
- ✅ 默认：呼气训练
- ✅ 右侧显示下拉箭头

#### 训练挡位
- ✅ 显示当前挡位数字（默认：6）
- ✅ 点击右侧下拉箭头可选择 1-10 挡
- ✅ 使用 PopupMenuButton 实现下拉选择
- ✅ 挡位 6 旁边显示红色"下拉选择"提示

#### 训练次数
- ✅ 文本输入框
- ✅ 只允许输入数字
- ✅ 右侧显示"手动输入"提示
- ✅ 默认值：1

### 4. **确定按钮**
- ✅ 灰色背景，全宽按钮
- ✅ 点击后跳转到问卷页面

### 5. **底部提示**
- ✅ 显示："填问卷这一步就让用户选择训练模式"

---

## 🔄 页面流程

```
设备连接页 → 版本选择页 → 【医生处方页】 → 问卷页 → 首页
                              ↓
                          点击"跳过"
                              ↓
                            首页
```

---

## 📱 UI 布局

```
┌─────────────────────────────────┐
│  ← 录入医生处方          跳过 →  │  AppBar
├─────────────────────────────────┤
│ 录入医生处方 │ 填写评估问卷      │  Tab 切换
├─────────────────────────────────┤
│                                 │
│  训练模式                        │
│  ┌─────────────────────────┐   │
│  │ 呼气训练           ▼    │   │  下拉选择
│  └─────────────────────────┘   │
│                                 │
│  训练挡位                        │
│  ┌─────────────────────────┐   │
│  │      6            ▼     │   │  下拉选择
│  └─────────────────────────┘   │  (挡位 6 → 下拉选择)
│                                 │
│  训练次数                        │
│  ┌─────────────────────────┐   │
│  │ 1             手动输入   │   │  文本输入
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │         确定             │   │  灰色按钮
│  └─────────────────────────┘   │
│                                 │
│  填问卷这一步就让用户选择训练模式  │  提示文字
│                                 │
└─────────────────────────────────┘
```

---

## 🎯 与原型图的对应

### 原型图要求：
✅ 右上角有跳过按钮
✅ 左右切换区域（录入医生处方 / 填写评估问卷）
✅ 训练模式下拉选择
✅ 训练挡位显示数字 + 下拉选择
✅ 训练次数手动输入
✅ 确定按钮
✅ 底部提示文字

### 已删除的内容：
❌ 患者姓名/昵称输入
❌ 性别选择
❌ 年龄输入
❌ 体重输入

---

## 🔧 技术实现

### 1. Tab 切换
```dart
int _selectedTab = 0; // 0-录入医生处方, 1-填写评估问卷

Widget _buildTabButton({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
})
```

- 选中时：蓝色背景 + 粗体白色文字 + 底部蓝色粗线
- 未选中：白色背景 + 黑色文字 + 底部灰色细线

### 2. 训练模式选择
```dart
String _trainingMode = '呼气训练';
final List<String> _trainingModes = ['呼气训练', '吸气训练', '振荡排痰'];

DropdownButton<String>(...)
```

### 3. 训练挡位选择
```dart
int _trainingLevel = 6;

PopupMenuButton<int>(
  itemBuilder: (context) {
    return List.generate(10, (index) {
      final level = index + 1;
      return PopupMenuItem<int>(
        value: level,
        child: Row(
          children: [
            Text('挡位 $level'),
            if (level == 6)
              Text('下拉选择', style: TextStyle(color: Colors.red)),
          ],
        ),
      );
    });
  },
)
```

### 4. 训练次数输入
```dart
final _trainingCountController = TextEditingController(text: '1');

TextField(
  controller: _trainingCountController,
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
)
```

### 5. 跳过功能
```dart
void _onSkip() {
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.home,
    (route) => false,
    arguments: widget.version,
  );
}
```

---

## 📝 数据传递

当前页面收集的数据：
- `_trainingMode`: 训练模式（呼气/吸气/振荡）
- `_trainingLevel`: 训练挡位（1-10）
- `_trainingCountController.text`: 训练次数

这些数据在后续版本可以：
1. 保存到本地存储（SharedPreferences）
2. 传递到首页作为默认设置
3. 在训练页面中使用

---

## 🚀 下一步

### 可选改进：

1. **实现"填写评估问卷"Tab**
   - 点击右侧Tab时切换内容
   - 显示问卷表单

2. **保存训练设置**
   - 使用 StorageService 保存设置
   - 在首页读取默认设置

3. **验证输入**
   - 训练次数不能为空
   - 训练次数必须大于 0

4. **优化UI**
   - 添加图标到训练模式选项
   - 添加挡位说明（如"挡位 1 - 低强度"）

---

## ✅ 测试

### 测试点：

- [ ] 右上角"跳过"按钮正常跳转到首页
- [ ] Tab 切换视觉效果正确（蓝色高亮）
- [ ] 训练模式下拉选择正常工作
- [ ] 训练挡位下拉选择正常工作（1-10）
- [ ] 训练次数只能输入数字
- [ ] "确定"按钮跳转到问卷页面
- [ ] 版本参数正确传递

---

## 📄 相关文件

- `lib/features/prescription/presentation/pages/doctor_prescription_page.dart` - 主页面文件
- `lib/app/routes.dart` - 路由配置
- `lib/features/questionnaire/presentation/pages/questionnaire_page.dart` - 问卷页面

---

## 🎉 总结

页面已完全重新设计，符合原型图要求：
- ✅ 不再是患者信息录入
- ✅ 改为训练参数设置
- ✅ 支持跳过功能
- ✅ Tab 切换区域
- ✅ 三个训练参数设置项
- ✅ 灰色确定按钮
- ✅ 底部提示文字

现在可以进行测试和部署！
