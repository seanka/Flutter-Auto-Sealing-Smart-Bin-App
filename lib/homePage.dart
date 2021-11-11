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
  String _lidStatusButton = '';
  final _database = FirebaseDatabase.instance.reference();
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription _readDatabase;
  late String _lidStatusImage = 'assets/images/bin-close.png';
  late int _lid;
  late int _lidHP;
  late int _humid = 0;
  late int _sealStatus;
  late String _wifiStatus = '';
  late String _lidStatusLight = 'assets/images/lid_false.png';
  late String _notification = 'notif here';

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    _database.child('/lidStatus').onValue.listen((event) {
      _lid = event.snapshot.value;
      setState(() {
        _lid == 1? _lidStatusImage = 'assets/images/bin-open.png' : _lidStatusImage = 'assets/images/bin-close.png';
        _lid == 1? _lidStatusButton = 'CLOSE LID' : _lidStatusButton = 'OPEN LID';
        _lid == 1? _lidStatusLight = 'assets/images/lid_true.png' : _lidStatusLight = 'assets/images/lid_false.png';
      });
    });

    _database.child('/lidStatusHP').onValue.listen((event) {
      _lidHP = event.snapshot.value;
    });

    _database.child('/humidity').onValue.listen((event) {
      _humid = event.snapshot.value;
      setState(() {
        _humid = _humid;
        if(_humid > 90) {
          _notification = 'Seal your trash ASAP';
        } else {
          _notification = '';
        }
      });
    });

    _database.child('/wifiSSID').onValue.listen((event) {
      _wifiStatus = event.snapshot.value;
      setState(() {
        _wifiStatus = _wifiStatus;
      });
    });

    _database.child('/sealStatus').onValue.listen((event) {
      _sealStatus = event.snapshot.value;
    });
  }

  void lidState() async {
    if (_lidHP == 1) {
      try {
        await database.update({'/lidStatusHP': 0});
      } catch (e) {}
    } else {
      try {
        await database.update({'/lidStatusHP': 1});
      } catch (e) {}
    }
  }

  void sealState() async {
    if(_sealStatus == 1) {
      try {
        await database.update({'/sealStatus': 0});
      } catch(e) {}
    } else {
      try {
        await database.update({'/sealStatus': 1});
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ThemeColors.mainColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          height: _screenHeight,
          child: Stack(
            children: <Widget> [
              Positioned(
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: _screenWidth * 0.95,
                  child: Image.asset('assets/images/bigTree.png'),
                ),
              ),

              // Positioned(
              //   left: 35,
              //   top: _screenHeight * 0.86,
              //   child: SizedBox(
              //     width: _screenWidth * 0.825,
              //     child: Image.asset('assets/images/sealProgres.gif'),
              //   ),
              // ),


              Column(
                children: <Widget> [
                  Container(
                    width: _screenWidth,
                    height: _screenHeight * 0.5,
                    child: Stack(
                      children: <Widget> [
                        Align(
                          alignment: const Alignment(0, 0.4),
                          child: SizedBox(
                            width: _screenWidth * 0.95,
                            child: const Image(
                              image: AssetImage('assets/images/background.png'),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {lidState();},
                              child: SizedBox(
                                child: Image(image: AssetImage(_lidStatusImage),),
                                height: _screenHeight * 0.45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                                  child: Container(
                                    width: _screenWidth * 0.45,
                                    height: _screenHeight * 0.125,
                                    decoration: cardDecoration,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                          const Text(
                                            "wifi status",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: ThemeColors.textColor,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w300
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 15, right: 15),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget> [
                                                  SizedBox(
                                                    height: _screenHeight * 0.025,
                                                    child: Image.asset(
                                                        'assets/images/wifi-icon.gif'
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    _wifiStatus,
                                                    style: descriptionText,
                                                  ),
                                                ]
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //HUMID BUTTON
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, top: 10),
                                  child: Container(
                                    width: _screenWidth * 0.45,
                                    height: _screenHeight * 0.125,
                                    decoration: cardDecoration,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                          const Text(
                                            "humidity",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: ThemeColors.textColor,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w300
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: <Widget> [
                                                SizedBox(
                                                  height: _screenHeight * 0.04,
                                                  child: Image.asset(
                                                      'assets/images/humid.gif'
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _humid.toString(),
                                                  style: descriptionText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              children: <Widget> [

                                //NOTIFICATION
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                                  child: Container(
                                    width: _screenWidth * 0.4,
                                    height: _screenHeight * 0.05,
                                    decoration: cardDecoration,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          _notification,
                                          style: descriptionText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //LID STATUS
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: InkWell(
                                    onTap: () { lidState(); },
                                    child: Container(
                                      width: _screenWidth * 0.4,
                                      height: _screenHeight * 0.2,
                                      decoration: cardDecoration,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                _lidStatusButton,
                                                style: descriptionText,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: SizedBox(
                                                height: 10,
                                                child: Image.asset(_lidStatusLight),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //SEAL BUTTON
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: InkWell(
                            onTap: () {sealState();},
                            child: Container(
                              width: _screenWidth * 0.9,
                              height: _screenHeight * 0.05,
                              decoration: cardDecoration,
                              child: Center(
                                child: Text(
                                  "SEAL NOW",
                                  style: descriptionText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                top: _screenHeight * 0.125,
                child: SizedBox(
                  width: _screenWidth * 0.185,
                  child: Image.asset('assets/images/vines.png'),
                ),
              ),
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
