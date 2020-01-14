import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
  /// 设置宽度
  static num setWidth(num width) {
    return ScreenUtil().setWidth(width);
  }

  /// 设置高度
  static num setHeight(num height) {
    return ScreenUtil().setHeight(height);
  }

  /// 设置字体大小
  static num setSp(num fontSize, {bool allowFontScalingSelf}) {
    return ScreenUtil().setSp(fontSize);
  }

  /// 获取屏幕宽度
  static double getScreenWidth() {
    return ScreenUtil.screenWidth;
  }

  /// 获取屏幕高度
  static double getScreenHeight() {
    return ScreenUtil.screenHeight;
  }
}
