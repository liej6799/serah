import 'dart:io';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:serah/service/storage.dart';

class StatementPage extends StatelessWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title = "Statement";
  late Future<FileList> storage;

  StatementPage({Key? key}) : super(key: key) {
    storage = StorageService().getList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileList>(
      future: storage,
      builder: (ctx, snapshot) {
        List<File> contacts = snapshot.data!.files;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildListView(contacts);
          default:
            return _buildLoadingScreen();
        }
      },
    );
  }

  Widget _buildListView(List<File> fileList) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return ContactCard(fileList[idx]);
      },
      itemCount: fileList.length,
    );
  }
}

Widget _buildLoadingScreen() {
  return Center(
    child: Container(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}

class ContactCard extends StatelessWidget {
  final File file;

  ContactCard(this.file);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('${file.bucketId}'), SizedBox(height: 2)],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.create,
                color: Colors.grey[600],
              ),
              SizedBox(width: 15.0),
              Icon(
                Icons.message,
                color: Colors.grey[600],
              ),
              SizedBox(width: 15.0),
              Icon(
                Icons.call,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
