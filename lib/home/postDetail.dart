import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale/models/posts.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail({required this.post});

  Widget buildGridView(context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: List.generate(
        post.images.length,
        (index) {
          return GestureDetector(
            child: Hero(
              tag: post.images[index],
              child: new Container(
                child: CachedNetworkImage(
                  imageUrl: post.images[index],
                  placeholder: (context, url) => new Center(
                    child: Container(
//                      width: 30,
//                      height: 30,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _card(
      {Color primaryColor = Colors.redAccent, required String imgPath}) {
    return Container(
      height: 190,
      width: 34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: -1,
                right: -235,
                child: _circularContainer(300, Colors.orange)),
            Positioned(
                top: -35,
                left: 15,
                child: _circularContainer(70, Colors.deepOrange)),
            Positioned(
                top: -33,
                right: -33,
                child: _circularContainer(80, Colors.transparent,
                    borderColor: Colors.white38)),
          ]),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 20,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: .7,
            child: _card(imgPath: ''),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          post.title,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircleAvatar(
                        radius: 3.5,
                        backgroundColor: Colors.orange,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('\$${post.price}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                Text(
                  post.description,
                  // style: AppTheme.h6Style.copyWith(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w500,
                  //     color: LightColor.extraDarkPurple)
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
