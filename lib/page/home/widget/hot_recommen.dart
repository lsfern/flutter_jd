import 'package:flutter/material.dart';
import 'package:flutter_jd/model/home/shop_list_model.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class HotRecommend extends StatelessWidget {
  final List<ShopListItem> list;

  const HotRecommend({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.length > 0) {
      return Container(
        padding: EdgeInsets.all(ScreenUtils.setWidth(20)),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _listItem(),
        ),
      );
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Text('加载中...'),
    );
  }

  List<Widget> _listItem() {
    return list.map((item) {
      return Container(
        width: (ScreenUtils.getScreenWidth() - 40) / 2,
        padding: EdgeInsets.all(ScreenUtils.setWidth(15)),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: Color.fromRGBO(233, 233, 233, 0.9))),
        child: Column(
          children: <Widget>[
            _renderImage(item),
            _renderTitle(item),
            _renderPrice(item)
          ],
        ),
      );
    }).toList();
  }

  Widget _renderImage(ShopListItem item) {
    return Container(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.network(
          "http://jd.itying.com/${item.pic.replaceAll('\\', '/')}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _renderTitle(ShopListItem item) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtils.setWidth(20)),
      child: Text(
        item.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(color: Colors.black54, fontSize: ScreenUtils.setSp(23)),
      ),
    );
  }

  Widget _renderPrice(ShopListItem item) {
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtils.setWidth(20)),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '¥${item.price}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '¥${item.oldPrice}',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough),
              ),
            )
          ],
        ));
  }
}
