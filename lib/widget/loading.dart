import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class Loading extends StatelessWidget {
  final bool isShowLoading;

  const Loading({Key key, this.isShowLoading = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isShowLoading
        ? Center(
            child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
//            width: ScreenUtils.setWidth(50),
//            height: ScreenUtils.setHeight(50),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtils.setWidth(10)),
                  child: Text(
                    '加载中...',
                    style: TextStyle(fontSize: ScreenUtils.setSp(26)),
                  ),
                )
              ],
            ),
          ))
        : Container(
            child: null,
          );
  }
}
