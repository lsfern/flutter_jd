import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/page/index_page.dart';
import 'package:flutter_jd/route/routers.dart';

void main() {
  final router = Router();
  Routes.configureRoutes(router);
  Routes.router = router;
  runApp(JdApp());
}

class JdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '京东',
        theme: ThemeData(primaryColor: Colors.white),
        onGenerateRoute: Routes.router.generator,
        home: IndexPage());
  }
}
