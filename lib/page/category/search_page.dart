import 'package:flutter/material.dart';
import 'package:flutter_jd/route/routers.dart';

class SearchPage extends StatelessWidget {
  final String title;

  const SearchPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.title);
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body:Center(
        child: InkWell(
          onTap: () {
            Routes.pop(context);
          },
          child: Text('测试路由返回'),
        ),
      ),
    );
  }
}
