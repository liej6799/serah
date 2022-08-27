import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../../service/storage.dart';

class StatementPreview extends StatefulWidget {
  const StatementPreview({Key? key, required this.fileId}) : super(key: key);

  final String fileId;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _StatementPreviewState createState() => _StatementPreviewState();
}

class _StatementPreviewState extends State<StatementPreview> {
  late Future<Uint8List> _image;

  Future<Uint8List> _getFilePreview() async {
    return StorageService().getFilePreview(widget.fileId);
  }

  @override
  void initState() {
    super.initState();
    _image = _getFilePreview();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _image,
      builder: (ctx, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
