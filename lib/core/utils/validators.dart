class Validators {
  // 验证手机号
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }

    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return '请输入正确的手机号';
    }

    return null;
  }

  // 验证验证码
  static String? validateVerificationCode(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入验证码';
    }

    if (value.length != 6) {
      return '验证码为6位数字';
    }

    final codeRegex = RegExp(r'^\d{6}$');
    if (!codeRegex.hasMatch(value)) {
      return '验证码格式不正确';
    }

    return null;
  }

  // 验证用户名
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }

    if (value.length < 2 || value.length > 20) {
      return '用户名长度为2-20个字符';
    }

    return null;
  }

  // 验证非空
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '请输入$fieldName';
    }
    return null;
  }
}
