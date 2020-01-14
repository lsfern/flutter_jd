import 'package:flutter/material.dart';
import 'package:flutter_jd/model/home/shop_list_model.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class LikeList extends StatelessWidget {
  final List<ShopListItem> list;

  const LikeList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.length > 0) {
      return Container(
        width: double.infinity,
        height: 130,
        margin: EdgeInsets.only(
            top: ScreenUtils.setWidth(25), left: ScreenUtils.setWidth(20)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list?.length ?? 0,
            itemBuilder: (context, index) {
              return listItem(index);
            }),
      );
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Text('加载中...'),
    );
  }

  Widget listItem(int index) {
    return Container(
        padding: EdgeInsets.only(right: ScreenUtils.setWidth(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 90,
              child: Image.network(
                "http://jd.itying.com/${list[index].pic.replaceAll('\\', '/')}",
                fit: BoxFit.cover,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: ScreenUtils.setWidth(20)),
                child: Text(
                  list[index].title.substring(0, 4),
                  style: TextStyle(
                      fontSize: ScreenUtils.setSp(26), color: Colors.black54),
                ))
          ],
        ));
  }
}
