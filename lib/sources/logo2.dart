import 'package:flutter/material.dart';

class Logo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'H',
          style: TextStyle(
            //style: Theme.of(context).textTheme.bodyText1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          // style: GoogleFonts.portLligatSans(
          //   textStyle: Theme.of(context).textTheme.bodyText1,
          //   fontSize: 30,
          //   fontWeight: FontWeight.w700,
          //   color: Color(0xffe46b10),
          // ),
          children: [
            TextSpan(
              text: 'yper',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Garage',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}
