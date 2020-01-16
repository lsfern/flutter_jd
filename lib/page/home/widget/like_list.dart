import 'package:flutter/material.dart';
import 'package:flutter_jd/common/config.dart';
import 'package:flutter_jd/model/home/shop_list_model.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class LikeList extends StatelessWidget {
  final List<ShopListItem> list;

  const LikeList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.length > 0) {
      return Container(
        height: ScreenUtils.setWidth(220),
        padding: EdgeInsets.all(ScreenUtils.setWidth(20)),
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
      child: Text(''),
    );
  }

  Widget listItem(int index) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: ScreenUtils.setWidth(21)),
          height: ScreenUtils.setWidth(140),
          width: ScreenUtils.setWidth(140),
          child: Image.network(
            Config.baseUrl + list[index].pic.replaceAll('\\', '/'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: ScreenUtils.setWidth(10)),
            height: ScreenUtils.setWidth(40),
            child: Text(
              "¥${list[index].price}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: ScreenUtils.setSp(26), color: Colors.black54),
            ))
      ],
    );
  }
}
