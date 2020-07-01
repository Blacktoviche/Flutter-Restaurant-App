import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnlineImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;
  final dynamic progress;
  final bool withRadious;

  const OnlineImage(this.image,
      {Key key,
      this.fit,
      this.height,
      this.width,
      this.progress,
      this.withRadious = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null || image.trim().isEmpty) {
      if (withRadious) {
        return Container(
          width: width,
          height: height,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: Constants.DARK_COLOR),
            //shape: BoxShape.circle,
            image: DecorationImage(
              image: Image.asset(
                "assets/images/noImg.png",
                //width: width,
                //height: height,
                //fit: fit,
              ).image,
              fit: fit,
            ),
          ),
        );
      } else {
        return Image.asset(
          "assets/images/noImg.png",
          width: width,
          height: height,
          fit: fit,
        );
      }
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        imageBuilder: withRadious
            ? (context, imageProvider) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Constants.DARK_COLOR),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                )
            : null,
        placeholder: (context, url) => Center(
            child: progress == null
                ? SpinKitThreeBounce(
                    color: Constants.PROGRESS_COLOR, size: 20.0)
                : progress),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
