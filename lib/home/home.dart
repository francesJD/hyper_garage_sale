import 'package:flutter/material.dart';
import 'package:hyper_garage_sale/authenticate/welcomePage.dart';
import 'package:hyper_garage_sale/home/newPost.dart';
import 'package:hyper_garage_sale/home/postList.dart';
import 'package:hyper_garage_sale/models/posts.dart';
import 'package:hyper_garage_sale/services/auth.dart';
import 'package:hyper_garage_sale/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService(uid: '').posts,
      initialData: [],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _header(context),
                PostList(),
              ],
            ),
          ),
        ),
        // create a floating button to navigate the create new post page
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewPost()));
          },
          icon: Icon(Icons.add),
          label: Text('NEW POST'),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
            color: Colors.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 8,
                  right: -120,
                  child: _circularContainer(300, Colors.orange)),
              Positioned(
                  top: -50,
                  left: -65,
                  child: _circularContainer(width * .5, Colors.orange)),
              Positioned(
                  top: -200,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: -5,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "HyperGarageSale",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ))),
              Positioned(
                  top: 40,
                  right: 0,
                  child: TextButton.icon(
                    icon: Icon(Icons.account_circle),
                    label: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    },
                  )),
            ],
          )),
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
}
