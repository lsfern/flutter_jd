import 'package:flutter/material.dart';
import 'package:flutter_jd/route/routers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Routes.navigateTo(context, Routes.search,
                params: {'title': '测试传参数 ? *&%6'});
          },
          child: Text('测试路由跳转'),
        ),
      ),
    );
  }
}
