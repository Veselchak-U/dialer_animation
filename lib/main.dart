import 'dart:math';

import 'package:dialer_animation/dialer_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final shortestScreenSide = MediaQuery.of(context).size.shortestSide;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter passcode'.toUpperCase(),
              style: Theme.of(context).textTheme.headline4,
            ),
            // SizedBox(
            //   height: shortestScreenSide,
            //   child:
            LayoutBuilder(
              builder: (context, size) {
                // print('!!! LayoutBuilder maxWidth = ${size.maxWidth}, maxHeight = ${size.maxHeight}');
                final dialerSize = min(size.maxWidth, size.maxHeight);
                return DialerWidget(dialerSize);
              },
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
