import 'package:flutter/material.dart';

class CommonUtil {
  /// 关闭软键盘
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 聚焦文本框
  static focusTextField(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
}
