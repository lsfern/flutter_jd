import 'package:flutter/material.dart';
import 'package:flutter_jd/common/config.dart';
import 'package:flutter_jd/model/home/shop_list_model.dart';
import 'package:flutter_jd/utils/common_util.dart';
import 'package:flutter_jd/utils/http_util.dart';
import 'package:flutter_jd/utils/screen_util.dart';
import 'package:flutter_jd/widget/loading.dart';

class ShopListPage extends StatefulWidget {
  final Map params;

  const ShopListPage({Key key, this.params}) : super(key: key);

  @override
  _ShopListPageState createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  List _tabBarList = [
    {
      'id': 1,
      'title': '综合',
      'sort': -1,
    },
    {
      'id': 2,
      'title': '销量',
      'fileds': 'salecount',
      'sort': -1,
    },
    {
      'id': 3,
      'title': '排序',
      'fileds': 'price',
      'sort': -1,
    },
    {'id': 4, 'title': '筛选'},
  ];
  List<ShopListItem> shopList = [];
  int _selTabId = 1;
  int _pageIndex = 1;
  int _pageSize = 10;

  // 是否显示加载中圈圈
  bool _isShowLoading = false;

  // 解决重复请求的问题
  bool _flag = true;

  // 是否有更多数据
  bool _hasMore = true;

  // 排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = "";

  TextEditingController _textEditingController = TextEditingController();
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _textEditingController.text = widget.params['keywords']?.first;
    _getShopList();
    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 20) {
        // 如果不在请求中且有更多数据
        if (_flag && _hasMore) {
          _getShopList(isLoadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    _textEditingController.dispose();
    _controller.dispose();
  }

  Future<void> _getShopList({bool isLoadMore = false}) async {
    try {
      setState(() {
        _isShowLoading = true;
      });
      if (isLoadMore) {
        _pageIndex++;
        setState(() {
          _flag = false;
        });
      } else {
        _pageIndex = 1;
        shopList = [];
        _hasMore = true;
      }
      var type = "";
      if (_textEditingController.text != null) {
        type = "search=${_textEditingController.text}";
      }
      if (widget.params['id']?.first != null) {
        type = "cid=${widget.params['id']?.first}";
      }
      var response = await HttpUtils.sendRequest(
          '/plist?$type&sort=$_sort&page=$_pageIndex&pageSize=$_pageSize',
          params: null,
          way: RequestWay.get);
      List<ShopListItem> list = ShopList.fromJson(response).result;
      if (list.length < _pageSize) {
        setState(() {
          shopList.addAll(list);
          _hasMore = false;
          _flag = true;
        });
      } else {
        setState(() {
          shopList.addAll(list);
          _flag = true;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isShowLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: AppBar(
        title: _titleContainer(),
        actions: <Widget>[
          InkWell(
            onTap: () {
              CommonUtil.hideKeyboard(context);
              _onTabClick(1);
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
      endDrawer: Drawer(
          child: Container(
        child: Text('测试侧边栏'),
      )),
      body: RefreshIndicator(
          onRefresh: _getShopList,
          child: Container(
            child: Stack(
              children: <Widget>[_listView(), _positionView()],
            ),
          )),
    );
  }

  /// 标题栏
  Widget _titleContainer() {
    return Container(
      height: ScreenUtils.setHeight(60),
      decoration: BoxDecoration(
          color: Color.fromRGBO(233, 233, 233, 0.8),
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: (value) {
          setState(() {
            _textEditingController.text = value;
          });
        },
      ),
    );
  }

  _listView() {
    if (shopList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenUtils.setHeight(80)),
        child: ListView.builder(
            controller: _controller,
            itemCount: shopList?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtils.setWidth(150),
                          height: ScreenUtils.setHeight(150),
                          child: Image.network(
                            Config.baseUrl +
                                shopList[index].pic.replaceAll("\\", "/"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: ScreenUtils.setHeight(150),
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    shopList[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: ScreenUtils.setHeight(40),
                                        margin: EdgeInsets.only(right: 10),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(
                                              230, 230, 230, 0.9),
                                        ),
                                        child: Text(
                                          '4g',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        height: ScreenUtils.setHeight(40),
                                        margin: EdgeInsets.only(right: 10),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(
                                              230, 230, 230, 0.9),
                                        ),
                                        child: Text(
                                          '256g',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "¥${shopList[index].price}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    _showMore(index)
                  ],
                ),
              );
            }),
      );
    } else {
      if (_isShowLoading) {
        return Loading(
          isShowLoading: _isShowLoading,
        );
      }
      return Center(
        child: Text('暂无数据...'),
      );
    }
  }

  _positionView() {
    return Positioned(
        top: 0,
        width: ScreenUtils.setWidth(750),
        height: ScreenUtils.setHeight(80),
        child: Container(
          width: ScreenUtils.setWidth(750),
          height: ScreenUtils.setHeight(80),
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)),
          )),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _tabBarList.map((item) {
                return Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {
                          _onTabClick(item['id']);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenUtils.setHeight(16),
                              0,
                              ScreenUtils.setHeight(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ScreenUtils.setSp(26),
                                  color: _selTabId == item['id']
                                      ? Colors.red
                                      : Colors.black54,
                                  fontWeight: _selTabId == item['id']
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                              _showIcon(item["id"])
                            ],
                          ),
                        )));
              }).toList()),
        ));
  }

  _onTabClick(int id) {
    if (id == 4) {
      _globalKey.currentState.openEndDrawer();
      setState(() {
        _selTabId = id;
      });
    } else {
      _pageIndex = 1;
      setState(() {
        _sort =
            "${_tabBarList[id - 1]["fileds"]}_${_tabBarList[id - 1]["sort"]}";
        //改变sort排序
        _tabBarList[id - 1]['sort'] = _tabBarList[id - 1]['sort'] * -1;
        _selTabId = id;
        _hasMore = true;
        _isShowLoading = true;
        shopList = [];
      });
      _getShopList();
    }
  }

  /// 显示header Icon
  _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_tabBarList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }
    return Text("");
  }

  _showMore(int index) {
    if (_hasMore) {
      return index == shopList.length - 1
          ? Loading(
              isShowLoading: _isShowLoading,
            )
          : Text("");
    } else {
      return index == shopList.length - 1 ? Text("--我是有底线的") : Text("");
    }
  }
}
