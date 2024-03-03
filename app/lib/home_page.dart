// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter({int add = 0, bool zero = false}) {
    if (zero) {
      setState(() {
        _counter = 0;
      });
    } else {
      setState(() {
      _counter += add;
    });
    }
    
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
          children: [
            SizedBox(
              height: 75.0,
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
        onPressed:() {
          setState(() {
            _incrementCounter(add: 1);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 84, 101, 131),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed:() {
                setState(() {
                  _incrementCounter(add: 5);
                });
              },
              icon: const Icon(Icons.settings_remote),
              color: Colors.black,
              hoverColor: Color.fromRGBO(50, 67, 88, 0.5),
              highlightColor: Color.fromRGBO(50, 67, 88, 1),
              tooltip: "Emitter",
              ),
              IconButton(
                onPressed:() {
                  setState(() {
                    _incrementCounter(zero: true);
                  });
                }, 
                icon: Icon(Icons.settings_remote_outlined),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
