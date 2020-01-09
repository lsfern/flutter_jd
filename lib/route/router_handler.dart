import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_jd/page/category/search_page.dart';
import 'package:flutter_jd/page/index_page.dart';

Handler rootHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return IndexPage();
});

Handler searchHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        String title = params['title']?.first;
  return SearchPage(
      title:title
  );
});
