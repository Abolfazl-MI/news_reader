import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double ? borderRadius;
  const CachedImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height, this.borderRadius,
      });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      errorWidget: ((context, url, error) => Container(
            width: width,
            height: height,
            color: Colors.grey,
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
              ),
            ),
          )),
      placeholder: ((context, url) => Container(
            width: width,
            height: height,
            child: Center(
              child: SpinKitDoubleBounce(
                color: Colors.blue[800],
              ),
            ),
          )),
      imageBuilder: ((context, imageProvider) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: borderRadius!=null?BorderRadius.circular(borderRadius!):null,
                image: DecorationImage(

              image: imageProvider,
              fit: BoxFit.fill,
            )),
          )),
    );
  }
}
