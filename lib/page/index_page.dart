import 'package:flutter/material.dart';
import 'package:flutter_jd/page/category/category.dart';
import 'package:flutter_jd/page/home/home.dart';
import 'package:flutter_jd/page/mine/my_page.dart';
import 'package:flutter_jd/page/shop/shop_cart.dart';
import 'package:flutter_jd/route/routers.dart';
import 'package:flutter_jd/utils/screen_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    PageController controller = PageController(
      initialPage: 0,
    );
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.center_focus_weak,
            size: 28,
            color: Colors.black54,
          ),
          title: InkWell(
            onTap: () {
              Routes.navigateTo(context, Routes.search);
            },
            child: Container(
              padding: EdgeInsets.only(left: ScreenUtils.setWidth(30)),
              height: ScreenUtils.setHeight(65),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.8),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black54,
                  ),
                  Text('笔记本',
                      style: TextStyle(
                          fontSize: ScreenUtils.setSp(24),
                          color: Colors.black54))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.message,
                size: 28,
                color: Colors.black54,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              controller.jumpToPage(_currentIndex);
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
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          controller: controller,
          children: _pageList,
        ));
  }
}
