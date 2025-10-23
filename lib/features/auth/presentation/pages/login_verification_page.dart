import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../../app/routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/constants/app_constants.dart';

class LoginVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const LoginVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginVerificationPage> createState() => _LoginVerificationPageState();
}

class _LoginVerificationPageState extends State<LoginVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  int _countdown = AppConstants.verificationCodeResendSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _onResendCode() async {
    if (_countdown > 0) return;

    setState(() {
      _countdown = AppConstants.verificationCodeResendSeconds;
    });
    _startCountdown();

    // 模拟重新发送验证码
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('验证码已重新发送')),
    );
  }

  Future<void> _onVerify() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟API调用验证
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    // 验证成功，跳转到用户信息设置页
    Navigator.pushReplacementNamed(context, AppRoutes.userInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // 标题
                Text(
                  '验证码',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),

                Text(
                  '验证码已发送至 ${_formatPhoneNumber(widget.phoneNumber)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 48),

                // 验证码输入框
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    labelText: '验证码',
                    hintText: '请输入6位验证码',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: TextButton(
                      onPressed: _countdown > 0 ? null : _onResendCode,
                      child: Text(
                        _countdown > 0 ? '${_countdown}s' : '重新发送',
                        style: TextStyle(
                          color: _countdown > 0 ? Colors.grey : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  validator: Validators.validateVerificationCode,
                  onFieldSubmitted: (_) => _onVerify(),
                ),
                const SizedBox(height: 32),

                // 验证按钮
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onVerify,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('验证'),
                  ),
                ),
                const SizedBox(height: 24),

                // 提示信息
                Center(
                  child: Text(
                    '收不到验证码？',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: 联系客服
                    },
                    child: const Text('联系客服'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatPhoneNumber(String phone) {
    if (phone.length == 11) {
      return '${phone.substring(0, 3)} **** ${phone.substring(7)}';
    }
    return phone;
  }
}
