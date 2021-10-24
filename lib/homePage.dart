import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'constant.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayText = 'aaaa';
  String _wifiStatus = '';
  String _lidStatusButton = '';
  final _database = FirebaseDatabase.instance.reference();
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription _readDatabase;
  late String _lidStatusImage = 'assets/images/bin-close.png';

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    _database.child('/data').onValue.listen((event) {
      final int description = event.snapshot.value;
      setState(() {
        // description == 483? _displayText = "TRUE" : _displayText = "FALSE";
        _displayText = description.toString();
      });
    });

    _database.child('/lidStatus').onValue.listen((event) {
      final int lid = event.snapshot.value;
      setState(() {
        lid == 1? _lidStatusImage = 'assets/images/bin-open.png' : _lidStatusImage = 'assets/images/bin-close.png';
        lid == 1? _lidStatusButton = 'CLOSE LID' : _lidStatusButton = 'OPEN LID';
      });
    });

    _database.child('/wifiSSID').onValue.listen((event) {
      final String wifiSSID = event.snapshot.value;
      setState(() {
        _wifiStatus = wifiSSID;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Container(
                color: ThemeColors.mainColor,
                width: _screenWidth,
                height: _screenHeight * 0.1,
                child: const Padding(
                  padding: EdgeInsets.only(top: 25, left: 30, bottom: 25),
                  child: Text(
                    "smart bin",
                    style: TextStyle(fontSize: 30, color: Color(0xFF807182), fontFamily: 'Sans-serif'),
                  ),
                ),
              ),

              Container(
                  color: ThemeColors.mainColor,
                  width: _screenWidth,
                  height: _screenHeight * 0.5,
                  child: Stack(
                    children: <Widget> [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: ThemeColors.mainColor2,
                          width: _screenWidth,
                          height: _screenHeight * 0.075,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: SizedBox(
                            child: Image(image: AssetImage(_lidStatusImage),),
                            height: _screenHeight * 0.45,
                          ),
                        ),
                      ),
                    ],
                  )
              ),

              Container(
                color: ThemeColors.mainColor2,
                height: _screenHeight * 0.35,
                width: _screenWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [

                              //WIFI STATUS
                              Padding(
                                padding: EdgeInsets.only(right: 10, bottom: 10),
                                child: Container(
                                  width: _screenWidth * 0.45,
                                  height: _screenHeight * 0.125,
                                  decoration: cardDecoration,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        Text(
                                          "status",
                                          style: TextStyle(fontSize: 15, color: Color(0xFF807182)),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget> [
                                            Padding(
                                              padding: EdgeInsets.only(top: 15, right: 15),
                                              child: SizedBox(
                                                height: _screenHeight * 0.025,
                                                child: Image.asset(
                                                    'assets/images/wifi-icon.gif'
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text(
                                                _wifiStatus,
                                                style: TextStyle(color: Color(0xFF807182), fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //LID STATUS
                              Padding(
                                padding: EdgeInsets.only(right: 10, top: 10),
                                child: Container(
                                  width: _screenWidth * 0.45,
                                  height: _screenHeight * 0.05,
                                  decoration: cardDecoration,
                                  child: Center(
                                    child: Text(
                                      _lidStatusButton,
                                      style: TextStyle(color: Color(0xFF807182), fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //HUMID BUTTON
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              width: _screenWidth * 0.4,
                              height: _screenHeight * 0.2,
                              decoration: cardDecoration,
                            ),
                          ),
                        ],
                      ),

                      //SEAL BUTTON
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: _screenWidth * 0.9,
                          height: _screenHeight * 0.05,
                          decoration: cardDecoration,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Text(_displayText, style: const TextStyle(fontSize: 50, color: Colors.black),),
              // ElevatedButton(
              //     onPressed: () async {
              //       try{
              //         await database.update({'/rgbString' : "10"});
              //       }catch (e) {
              //
              //       }
              //     },
              //     child: const Text("update data",))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _readDatabase.cancel();
    super.deactivate();
  }
}
