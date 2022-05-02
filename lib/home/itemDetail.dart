import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale/home/imageDetail.dart';
import 'package:hyper_garage_sale/models/posts.dart';

class ItemDetail extends StatelessWidget {
  final Post post;

  ItemDetail({required this.post});

  Widget buildGridView(context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
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
                      width: 30,
                      height: 30,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageDetail(post.images[index], post.images[index])));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 10.0,
        title:
            Text('Item Detail', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Title: ' + post.title,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Price: ' + ' \$${post.price}',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Description: ' + post.description,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              post.images.length == 0
                  ? SizedBox(
                      height: 20.0,
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Show images here: ',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20.0,
              ),
              post.images.length == 0
                  ? new Text("User didn't upload images.")
                  : Expanded(
                      child: buildGridView(context),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
