import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/util/size_config.dart';

class PrimarySlider extends StatelessWidget {
  final List<String> images;

  const PrimarySlider({
    Key key,
    this.images,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      height: SizeConfig.safeBlockVertical * 40,
      initialPage: 0,
      autoPlay: false,
      enableInfiniteScroll: true,
      onPageChanged: (index) {},
      items: images.map(
        (image) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(
                image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              );
            },
          );
        },
      ).toList(),
    );
  }
}
