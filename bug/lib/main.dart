import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Call C++ from Java'),
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
  static const platform = const MethodChannel("com.flutter.java");
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter number to power it"
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text('Get Power from C++'),
                onPressed:() {_powerMethod(int.tryParse(_controller.text));},
              ),
              Text(_sum),
            ],
          ),
        ),
      ),
    );
  }

  String _sum = '0';

  Future<void> _powerMethod(int sum) async {
    String string;
    try {
      final int result = await platform.invokeMethod('powerMethod', {'int': sum});
      string = "The power of $sum is $result";
    } on PlatformException catch (e) {
      string = "Failed to get sum: '${e.message}'.";
    }

    setState(() {
      _sum = string;
    });
  }
}