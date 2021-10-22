import 'package:flutter/material.dart';

class FirstContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget> [
        Container(
          color: Colors.blue,
          width: _screenWidth,
          child: const Padding(
            padding: EdgeInsets.only(top: 25, left: 30, bottom: 25),
            child: Text(
              "smart bin",

            ),
          ),
        ),

        Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget> [
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.red,
                  width: _screenWidth,
                  height: _screenHeight * 0.1,
                ),
              ),

              Center(
                child: SizedBox(
                  child: Image(image: AssetImage('assets/images/bin-open.png'),),
                  height: _screenHeight * 0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}