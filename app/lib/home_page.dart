import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            SizedBox(
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawerHeader(
                    child: Text(
                      'Devices',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.settings),
                    padding: EdgeInsets.only(right: 15.0),
                  )
                ],
              ),
            ),
              ListTile(
                leading: Icon(Icons.settings_remote),
                title: Text('Page 1')
                ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text('Page 2'),
                )
          ],
       ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
