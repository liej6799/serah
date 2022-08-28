import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../../helper/common.dart';
import '../../helper/widgets.dart';
import '../../service/storage.dart';

class StatementDetail extends StatefulWidget {
  const StatementDetail({Key? key, required this.fileId}) : super(key: key);

  final String fileId;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _StatementDetailState createState() => _StatementDetailState();
}

class _StatementDetailState extends State<StatementDetail> {
  late Future<File> _file;

  Future<File> _getFile() async {
    return StorageService().getFile(widget.fileId);
  }

  @override
  void initState() {
    super.initState();
    _file = _getFile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _file,
      builder: (ctx, snapshot) {
        File? contacts = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildForm(contacts!);

          default:
            return Widgets().buildCenterCirular();
        }
      },
    );
  }

  Widget _buildForm(File file) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            readOnly: true,
            initialValue: file.$id,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'File Id',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            readOnly: true,
            initialValue: file.bucketId,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Bucket Id',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            readOnly: true,
            initialValue: file.name,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            readOnly: true,
            initialValue: Common().convertTimeStampToDateTime(file.$createdAt),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Created At',
            ),
          ),
        ),
      ],
    );
  }
}
