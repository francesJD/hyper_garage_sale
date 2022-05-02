import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDetail extends StatelessWidget {
  final String index;
  final String url;

  ImageDetail(this.index, this.url)
      : assert(index != null),
        assert(url != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Center(
            child: Hero(
              tag: index,
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => new Center(
                    child: Container(
                        width: 32,
                        height: 32,
                        child: new CircularProgressIndicator())),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.orange,
            elevation: 0.0,
          ),
          body: new Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
