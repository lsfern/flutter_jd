/// 首页Swiper组件
import 'package:flutter/material.dart';
import 'package:flutter_jd/model/home/swiper_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSwiper extends StatelessWidget {
  final List<SwiperModelItem> swiperList;

  const HomeSwiper({Key key, this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (swiperList.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                "http://jd.itying.com/${swiperList[index].pic.replaceAll('\\', '/')}",
                fit: BoxFit.cover,
              );
            },
            itemCount: swiperList.length,
            pagination: SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: Text('加载中...'),
      );
    }
  }
}
