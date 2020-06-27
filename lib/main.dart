import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'util/firebase_util.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drogo Libro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Drogo Libro Home Page'),
      navigatorObservers: kIsWeb ? 
      [] : <NavigatorObserver>[FirebaseUtil.shared().observer],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    FirebaseUtil.shared().sendViewEvent(route: AnalyticsRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times.\n'
                  'This includes all devices, ever.',
            ),
            Text(
              " ",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTapped,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _incrementTapped() async {
    // Increment counter in transaction.
    FirebaseUtil.shared().sendButtonEvent(buttonName: "Increment");
  }

  @override
  void dispose() {
    super.dispose();
  }

}
