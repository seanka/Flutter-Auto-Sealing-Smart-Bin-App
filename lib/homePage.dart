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
                        height: _screenHeight * 0.075,
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

              Container(
                width: _screenWidth,
                height: _screenHeight,
                color: Colors.yellow,
                child: Column(
                  children: <Widget> [

                  ],
                ),
              ),

              Text(_displayText, style: const TextStyle(fontSize: 50, color: Colors.black),),
              ElevatedButton(
                  onPressed: () async {
                    try{
                      await database.update({'/rgbString' : "10"});
                    }catch (e) {

                    }
                  },
                  child: const Text("update data",))
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
