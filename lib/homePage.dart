import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayText = 'aaaa';
  final _database = FirebaseDatabase.instance.reference();
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription _readDatabase;
  late String _lidStatusImage;

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
      final int lidStatus = event.snapshot.value;
      setState(() {
        lidStatus == 1? _lidStatusImage = 'assets/images/bin-open.png' : _lidStatusImage = 'assets/images/bin-close.png';
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
                color: Colors.blue,
                width: _screenWidth,
                height: _screenHeight * 0.1,
                child: const Padding(
                  padding: EdgeInsets.only(top: 25, left: 30, bottom: 25),
                  child: Text(
                    "smart bin",

                  ),
                ),
              ),

              Container(
                  color: Colors.blue,
                  width: _screenWidth,
                  height: _screenHeight * 0.5,
                  child: Stack(
                    children: <Widget> [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Colors.red,
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
                color: Colors.red,
                height: _screenHeight * 0.35,
                width: _screenWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(right: 10, bottom: 10),
                                child: Container(
                                  width: _screenWidth * 0.4,
                                  height: _screenHeight * 0.125,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white12,
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10, top: 5),
                                child: Container(
                                  width: _screenWidth * 0.4,
                                  height: _screenHeight * 0.05,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white12,
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              width: _screenWidth * 0.4,
                              height: _screenHeight * 0.185,
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white12,
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          width: _screenWidth * 0.85,
                          height: _screenHeight * 0.05,
                          decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white12,
                                  blurRadius: 10.0,
                                )
                              ]
                          ),
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
