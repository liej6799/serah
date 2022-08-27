import 'package:flutter/material.dart';
import 'package:serah/pages/statement/statement_detail.dart';
import 'package:serah/pages/statement/statement_list.dart';

import '../../main.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({Key? key, required this.page}) : super(key: key);

  final Widget page;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _StatementPageState createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Statement'),
        ),
        body: getBody(),
        floatingActionButton: Visibility(
            visible: getFloatingActionBarVisibility(), // Set it to false
            child: getFloatingActionBar()),
        drawer: getDrawer()
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget getBody() {
    return widget.page;
  }

  bool getFloatingActionBarVisibility() {
    if (widget.page.toString() == "StatementList") {
      return true;
    }
    return false;
  }

  FloatingActionButton getFloatingActionBar() {
    return FloatingActionButton(
      onPressed: () {
        print("pressed");
        // Add your onPressed code here!
      },
      child: const Icon(Icons.add),
    );
  }

  Drawer getDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
          ),
          ListTile(
            title: const Text('Statement'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              if (widget.page.toString() == "StatementDetail") {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
