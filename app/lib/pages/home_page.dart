// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:app/components/custom_drawer.dart';
import 'package:app/components/custom_navigation_bar.dart';
import 'package:app/components/tab_manager/tab_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('HomeScreen'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.black, // border color
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2), // border width
                child: Container(
                  // or ClipRRect if you need to clip the content
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // inner circle color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: TabManager(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            TabManager().index = 0;
          });
        },
        //tooltip: 'Increment',
        shape: CircleBorder(),
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
