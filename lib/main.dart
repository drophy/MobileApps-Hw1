import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _liked = false;
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Click the FAB'),
        // Like button
        actions: [
          IconButton(
              icon: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                  color: _liked ? Colors.red : Colors.white,
                  size: 28,
                  semanticLabel: 'Like button'),
              onPressed: () {
                setState(() {
                  _liked = !_liked;
                  _clickCount++;
                });
              })
        ],
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: Container(
          child: Text("You've clicked the FAB $_clickCount times"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Peekaboo!"),
              duration: Duration(milliseconds: 3000),
              backgroundColor: Colors.black54,
              action: _clickCount%2 == 0? null : SnackBarAction(label: 'Show Time', onPressed: () => {
                showDialog(
                  context: context,
                  builder: (_) {
                    var now = new DateTime.now();
                    return AlertDialog(
                      title: Text("Current date and time"),
                      content: Text("Today is ${now.day}/${now.month}/${now.year}. Time: ${now.hour}:${now.minute} ${now.timeZoneName}"),
                      actions: <Widget> [
                        FlatButton(onPressed: () { Navigator.of(context).pop(); }, child: Text("Dismiss"))
                      ],
                    );
                  }
                )
              })
            ));
        },
        child: Icon(Icons.add,
            size: 32, semanticLabel: 'Floating Action Button (FAB)'),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
