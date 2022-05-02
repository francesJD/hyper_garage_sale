import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'H',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'yper ',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            TextSpan(
              text: 'Garage',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ]),
    );
    // return Scaffold(
    // appBar: AppBar(
    // title: Text('Hyper Garage Sale'),
    // ),
    // body: Container(
    // color: Colors.white,
    // child: Image.asset('assets/images/logo.jpg',
    // ),
    // ),
    // );
  }
}
