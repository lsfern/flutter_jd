import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/page/index_page.dart';
import 'package:flutter_jd/route/routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  final router = Router();
  Routes.configureRoutes(router);
  Routes.router = router;
  runApp(JdApp());
}

class JdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return MaterialApp(
        title: '京东',
        theme: ThemeData(primaryColor: Colors.red),
        onGenerateRoute: Routes.router.generator,
        home: IndexPage());
  }
}
