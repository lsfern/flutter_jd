import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jd/model/home/shop_list_model.dart';
import 'package:flutter_jd/model/home/swiper_model.dart';
import 'package:flutter_jd/page/home/widget/swpier.dart';
import 'package:flutter_jd/utils/http_util.dart';
import 'package:flutter_jd/widget/cache_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SwiperModel homeSwiperModel;

  // 猜你喜欢
  ShopList hotList;
  // 热门推荐
  ShopList bestList;

  @override
  void initState() {
    super.initState();
    getSwiperData();
    geBestData();
    getHotData();
  }

  getSwiperData() async {
    var response = await HttpUtils.sendRequest('/focus',
        params: null, way: RequestWay.get);
    setState(() {
      homeSwiperModel = SwiperModel.fromJson(response);
    });
  }

  geBestData() async {
    String url = '/plist?is_best=1';
    var response =
        await HttpUtils.sendRequest(url, params: null, way: RequestWay.get);
    setState(() {
      bestList = ShopList.fromJson(response);
    });
  }

  getHotData() async {
    String url = '/plist?is_hot=1';
    var response =
        await HttpUtils.sendRequest(url, params: null, way: RequestWay.get);
    setState(() {
      hotList = ShopList.fromJson(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
            child: ListView(
              children: <Widget>[
                HomeSwiper(
                  swiperList: homeSwiperModel?.result ?? [],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 2,color: Colors.red)
                    )
                  ),
                  child: Text('猜你喜欢',style: TextStyle(fontSize: 16,color: Colors.black54),),
                )
              ],
            ),
          )),
    );
  }
}
