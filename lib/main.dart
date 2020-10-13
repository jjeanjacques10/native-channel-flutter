import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter - Channel Android'),
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
  static const chanel = const MethodChannel('fiap.flutter.dev/geral');
  String _batteryLevel = 'Desconhecido';
  String _networkType = 'Desconhecido';

  Future<void> _getBatteryLevel() async {
    String batteryLevel = '';
    try {
      int valor = await chanel.invokeMethod('getBatteryLevel');
      batteryLevel = '$valor%';
    } on PlatformException catch (e) {
      batteryLevel = "Erro: ${e.message}";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getNetWorkType() async {
    String network = '';
    try {
      String valor = await chanel.invokeMethod('getNetworkDetails');
      network = '$valor';
    } on PlatformException catch (e) {
      network = "Erro: ${e.message}";
    }

    setState(() {
      _networkType = network;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '🔋 Battery Level 🔋',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '$_batteryLevel',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '💻 Network 💻',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '$_networkType',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getBatteryLevel();
          _getNetWorkType();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
