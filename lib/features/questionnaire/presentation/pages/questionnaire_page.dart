import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class QuestionnairePage extends StatefulWidget {
  final String version;

  const QuestionnairePage({
    super.key,
    required this.version,
  });

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final Map<int, String> _answers = {};

  List<QuestionItem> get _questions {
    // 根据版本返回不同的问题
    if (widget.version == '儿童版') {
      return _childrenQuestions;
    } else {
      return _adultQuestions;
    }
  }

  // 儿童版问题
  final List<QuestionItem> _childrenQuestions = [
    QuestionItem(
      id: 1,
      question: '01. 过去 4 周内，您有过咳嗽的困扰吗？',
      options: [
        '无或很少 ≤2d/次',
        '有时候有',
        '经常有 ≥5d/次',
        '几乎每天 几乎每天',
      ],
    ),
    QuestionItem(
      id: 2,
      question: '02. 怎样呼出黏液最省力？',
      options: [
        '几乎没有',
        '有些费力',
        '很费力',
      ],
    ),
    QuestionItem(
      id: 3,
      question: '03. 呼吸困难致胸闷的频率是怎样的？',
      options: [
        '从不 0d/次',
        '很少 1-2d/次',
        '有时候 3-4d/次',
        '经常 5-6d/次',
        '很频繁 每天',
      ],
    ),
  ];

  // 成人版问题
  final List<QuestionItem> _adultQuestions = [
    QuestionItem(
      id: 1,
      question: '01. 过去 4 周内，注意力和呼吸情况怎么样？',
      options: [
        '从不紧张  0次/周',
        '很少 1-2d/次',
        '有时候 3-4d/次',
        '经常 5d/次',
        '一直 每天',
      ],
    ),
    QuestionItem(
      id: 2,
      question: '02. 怎样呼出黏液最省力？',
      options: [
        '几乎没有困难',
        '有些困难',
        '很困难的程度/完全不可能',
      ],
    ),
    QuestionItem(
      id: 3,
      question: '03. 呼吸困难影响您的有效性吗？',
      options: [
        '从不影响',
        '不太大影响',
        '一般影响',
        '影响',
        '影响巨大',
      ],
    ),
  ];

  void _onSubmit() {
    // 检查是否所有问题都已回答
    if (_answers.length < _questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请回答所有问题')),
      );
      return;
    }

    // 提交成功，跳转到首页
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
      arguments: widget.version,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isChildVersion = widget.version == '儿童版';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.version} - 调查问卷'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 提示
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: isChildVersion
                  ? const Color(0xFF4FC3F7).withValues(alpha: 0.1)
                  : const Color(0xFF66BB6A).withValues(alpha: 0.1),
              child: Text(
                isChildVersion
                    ? '请根据儿童的实际情况如实回答下列问题'
                    : '请根据您的实际情况如实回答下列问题',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),

            // 问题列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return _buildQuestionCard(question);
                },
              ),
            ),

            // 提交按钮
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('提交'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(QuestionItem question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 问题标题
            Text(
              question.question,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            // 选项
            ...question.options.asMap().entries.map((entry) {
              final optionIndex = entry.key;
              final option = entry.value;
              final isSelected = _answers[question.id] == option;

              return InkWell(
                onTap: () {
                  setState(() {
                    _answers[question.id] = option;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                        : Colors.grey[50],
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class QuestionItem {
  final int id;
  final String question;
  final List<String> options;

  QuestionItem({
    required this.id,
    required this.question,
    required this.options,
  });
}
