import 'dart:io';

import 'package:flutter/material.dart';
import 'package:serah/pages/statement/statement_preview.dart';

class StatementPage extends StatefulWidget {
  const StatementPage(
      {Key? key, required this.page, required this.title, required this.fileId})
      : super(key: key);

  final Widget page;
  final String title;
  final String fileId;
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
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          Visibility(
              visible: getDownloadButtonVisibility(),
              child: IconButton(
                // onPressed: () {
                //   StorageService().getFileDownload(widget.fileId).then((bytes) {
                //     final file = File('statement.pdf');
                //     file.writeAsBytesSync(bytes);
                //   }).catchError((error) {
                //     print(error);
                //   });
                // },
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StatementPage(
                              fileId: widget.fileId,
                              title: "Statement Preview",
                              page: StatementPreview(
                                fileId: widget.fileId,
                              ))));
                },
                icon: Icon(Icons.picture_as_pdf),
              ))
        ],
      ),

      body: getBody(),
      floatingActionButton: Visibility(
          visible: getFloatingActionBarVisibility(), // Set it to false
          child: getFloatingActionBar()),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getBody() {
    return widget.page;
  }

  bool getDownloadButtonVisibility() {
    if (widget.page.toString() == "StatementDetail") {
      return true;
    }
    return false;
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
}
