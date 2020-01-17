import 'package:flutter/material.dart';
import 'package:flutter_jd/common/config.dart';
import 'package:flutter_jd/model/category/category_model.dart';
import 'package:flutter_jd/route/routers.dart';
import 'package:flutter_jd/utils/http_util.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selIndex = 0;
  List<CateGoryModelItem> category;
  List<CateGoryModelItem> shop;
  @override
  void initState() {
    super.initState();
    _getLeftData();
  }

  _getLeftData() async {
    var response = await HttpUtils.sendRequest('/pcate',
        params: null, way: RequestWay.get);
    setState(() {
      CateGoryModel cateGoryModel = CateGoryModel.fromJson(response);
      setState(() {
        category = cateGoryModel.result;
      });
    });
    _getRightData(category[0].sId);
  }

  _getRightData(pid) async {
    var response = await HttpUtils.sendRequest('/pcate?pid=$pid',
        params: null, way: RequestWay.get);
    setState(() {
      CateGoryModel cateGoryModel = CateGoryModel.fromJson(response);
      setState(() {
        shop = cateGoryModel.result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //左侧宽度
    var leftWidth = ScreenUtils.getScreenWidth() / 4;
    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3
    var rightItemWidth =
        (ScreenUtils.getScreenWidth() - leftWidth - 20 - 20) / 3;
    //获取计算后的宽度
    rightItemWidth = ScreenUtils.setWidth(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenUtils.setHeight(28);

    return Container(
        child: Row(
      children: <Widget>[
        Container(
          width: leftWidth,
          height: double.infinity,
          color: Colors.white,
          child: ListView.builder(
              itemCount: category?.length ?? 0,
              itemBuilder: (context, index) {
                return _leftView(index);
              }),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(ScreenUtils.setWidth(10)),
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                  itemCount: shop?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return _rightView(context, index);
                  }),
            )),
      ],
    ));
  }

  Widget _leftView(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selIndex = index;
          _getRightData(category[index].sId);
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            color: _selIndex == index
                ? Color.fromRGBO(233, 233, 233, 0.9)
                : Colors.white,
            height: ScreenUtils.setWidth(84),
            width: ScreenUtils.getScreenWidth() / 4,
            padding: EdgeInsets.only(top: ScreenUtils.setWidth(28)),
            child: Text(
              category[index].title,
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _rightView(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Map<String,dynamic> map = {
          'id': shop[index].sId,
          'title':shop[index].title
        };
        Routes.navigateTo(context, Routes.shopList,
            params: map);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                Config.baseUrl + shop[index].pic.replaceAll('\\', '/'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtils.setWidth(10)),
              height: ScreenUtils.setHeight(28),
              child: Text("${shop[index].title}"),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
