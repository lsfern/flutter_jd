import 'package:flutter/material.dart';
import 'package:flutter_jd/route/routers.dart';
import 'package:flutter_jd/utils/common_util.dart';
import 'package:flutter_jd/utils/screen_util.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focusNode;
  final List _hotList = [
    {
      'title': '超级秒杀',
    },
    {
      'title': '笔记本',
    },
    {
      'title': '电脑笔记本',
    },
    {
      'title': '计算机',
    },
    {
      'title': 'iPhone',
    },
    {
      'title': '1',
    },
    {
      'title': 'iPhone111',
    },
    {
      'title': 'iPhone222',
    },
    {
      'title': 'iPhone333',
    },
    {
      'title': 'iPhone44',
    },
    {
      'title': 'iPhone55',
    }
  ];
  String _value = "";

  @override
  void initState() {
    super.initState();
    focusNode =FocusNode();
  }
  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: _titleContainer(),
          actions: <Widget>[
            InkWell(
              onTap: () {
                CommonUtil.hideKeyboard(context);
                Routes.navigateTo(context, Routes.shopList,
                    params: {'keywords': _value}, replace: true);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: ScreenUtils.setWidth(20)),
                    child: Text('搜索'),
                  )
                ],
              ),
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(ScreenUtils.setHeight(10)),
            child: ListView(
              children: <Widget>[
                _hotAndHisTitleView(isHis: false),
                Divider(),
                SizedBox(
                  height: ScreenUtils.setHeight(10),
                ),
                _hotSearch(),
                SizedBox(
                  height: ScreenUtils.setHeight(20),
                ),
                _hotAndHisTitleView(),
                Divider(),
                _historyView(),
                SizedBox(
                  height: ScreenUtils.setHeight(100),
                ),
                _clearButtonView()
              ],
            )));
  }


  /// 标题栏
  Widget _titleContainer() {
    return Container(
      height: ScreenUtils.setHeight(60),
      decoration: BoxDecoration(
          color: Color.fromRGBO(233, 233, 233, 0.8),
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        autofocus: true,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
      ),
    );
  }

  Widget _hotAndHisTitleView({isHis: true}) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.setWidth(10)),
      child: Text(
        isHis ? "历史搜索" : "热搜",
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _hotSearch() {
    return Wrap(
        children: _hotList.map((item) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(233, 233, 233, 0.8)),
        child: Text(item['title']),
      );
    }).toList());
  }

  Widget _historyView() {
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('女装'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('女装'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('女装'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('女装'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.comment),
          title: Text('女装'),
        ),
        Divider(),
      ],
    ));
  }

  Widget _clearButtonView() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
            left: ScreenUtils.setWidth(50), right: ScreenUtils.setWidth(50)),
        height: ScreenUtils.setHeight(64),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 0.8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
        ),
      ),
    );
  }
}
