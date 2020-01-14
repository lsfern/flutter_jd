import 'package:flutter/material.dart';
import 'package:flutter_jd/page/category/category.dart';
import 'package:flutter_jd/page/home/home.dart';
import 'package:flutter_jd/page/mine/my_page.dart';
import 'package:flutter_jd/page/shop/shop_cart.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    ShopCartPage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          fixedColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text('分类'), icon: Icon(Icons.category)),
            BottomNavigationBarItem(
                title: Text('购物车'), icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(
                title: Text('我的'), icon: Icon(Icons.people)),
          ],
        ),
        body: _pageList[_currentIndex]);
  }
}
