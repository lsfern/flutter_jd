import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/route/router_handler.dart';

class Routes {
  static Router router;
  static String root = '/';
  static String search = '/search';
  static String shopList = '/shopList';

  // 配置route
  static void configureRoutes(Router router) {
    // 未发现对应route
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('route not found!');
      return Container(
        child: Text('ROUTER IS NOT FOUND!!!'),
      );
    });

    router.define(root, handler: rootHandler); // 根目录
    router.define(search, handler: searchHandler); // 测试搜索
    router.define(shopList, handler: shopListHandler); // 商品列表
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
      TransitionType transition = TransitionType.inFromRight}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    path = path + query;
    return router.navigateTo(context, path, transition: transition);
  }

  /// 返回界面
  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 返回根路由
  static popUntil(BuildContext context) {
    Navigator.of(context).popUntil((r) => r.settings.isInitialRoute);
  }

  /// 返回指定界面
  static popToPage(BuildContext context, String path) {
    Navigator.of(context).popUntil(ModalRoute.withName(path));
  }
}
