import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:oop_lab22/home.dart';
import 'package:oop_lab22/static_shapes.dart';

import 'drawing_boards/drawing_board_line.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
          ),

        ),

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                  ),
                  Image.asset(
                    'assets/geometric_shapes.jpg',
                    height: 200,
                    width: 300,
                  ),
                  Text(
                    'Drawing App',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white60),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Material(
                    elevation: 5,
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(title: 'Drawing Board'))),
                      minWidth: 300,
                      height: 50,
                      child: Text(
                        'Drawing Board',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Material(
                  //   elevation: 5,
                  //   color: Colors.black54,
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: MaterialButton(
                  //     onPressed: () => Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //             builder: (context) => DrawingBoardLine(title: 'Drawing Board Line'))),
                  //     minWidth: 300,
                  //     height: 50,
                  //     child: Text(
                  //       'Drawing Board for line',
                  //       style: TextStyle(color: Colors.white, fontSize: 15),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StaticShapes())),
                      minWidth: 300,
                      height: 50,
                      child: Text(
                        'Static Shapes',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      // onPressed: () {
                      //   _openGanna () async {
                      //     bool isInstalled = await DeviceApps.isAppInstalled('com.jio.media.jiobeats');
                      //     if (bool != false)       DeviceApps.openApp('sjuniverse');
                      //     else Text("Cannot open app");
                      //   }
                      // }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}