import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_jd/page/index_page.dart';
import 'package:flutter_jd/page/search/search.dart';
import 'package:flutter_jd/page/shop_list.dart';

Handler rootHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return IndexPage();
});

Handler searchHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SearchPage();
});

Handler shopListHandler =
Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ShopListPage(params: params,);
});
