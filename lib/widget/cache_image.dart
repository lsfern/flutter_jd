//import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//
//class CacheImage extends StatelessWidget {
//  final String url;
//
//  const CacheImage({Key key, this.url}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return CachedNetworkImage(
//      imageUrl: url,
//      imageBuilder: (context, imageProvider) => Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//              image: imageProvider,
//              fit: BoxFit.cover,
//              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//        ),
//      ),
//      placeholder: (context, url) => CircularProgressIndicator(),
//      errorWidget: (context, url, error) => Icon(Icons.error),
//    );
//  }
//}
