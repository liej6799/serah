import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart';

import '../../helper/widgets.dart';
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
  late Future<String> _temporaryDirectoryPath;

  Future<Uint8List> _getFileDownload() async {
    return StorageService().getFileDownload(widget.fileId);
  }

  Future<String> _getTemporaryDirectory() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  @override
  void initState() {
    super.initState();
    _image = _getFileDownload();
    _temporaryDirectoryPath = _getTemporaryDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_image, _temporaryDirectoryPath]),
      builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.data?[0] != null && snapshot.data?[1] != null) {
          final file = File(snapshot.data?[1] + 'statement.pdf');
          file.writeAsBytesSync(snapshot.data?[0]);
          return SfPdfViewer.file(file);
        } else {
          return Widgets().buildCenterCirular();
        }
      },
    );
  }
}
