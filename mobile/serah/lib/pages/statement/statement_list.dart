import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:serah/pages/statement/statement_detail.dart';
import 'package:serah/pages/statement/statement_page.dart';
import 'package:serah/pages/statement/statement_preview.dart';
import 'package:serah/service/storage.dart';

class StatementList extends StatefulWidget {
  const StatementList({Key? key}) : super(key: key);

  @override
  _StatementListState createState() => _StatementListState();
}

class _StatementListState extends State<StatementList> {
  late Future<FileList> _fileList;

  Future<FileList> _getFileList() async {
    return StorageService().getList();
  }

  @override
  void initState() {
    super.initState();
    _fileList = _getFileList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileList>(
      future: _fileList,
      builder: (ctx, snapshot) {
        FileList? contacts = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildListView(contacts!.files);

          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildListView(List<File> fileList) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StatementPage(
                        page: StatementDetail(
                      fileId: fileList[index].$id,
                    ))),
          )
        },
        title: Text(fileList[index].name),
        subtitle: Text(fileList[index].$createdAt.toString()),
      ),
      itemCount: fileList.length,
    );
  }
}
