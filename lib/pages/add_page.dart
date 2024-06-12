import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, required this.databases});

  final Databases databases;

  addURLS(String url) async {
    final result = await databases.createDocument(
        databaseId: '66693da4001556742582',
        collectionId: '666942ae001eeafa098c',
        documentId: ID.unique(),
        data: {
          'fullURL': url,
          'shortURL': url,
        });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    String url = '';
    return Scaffold(
      appBar: AppBar(title: const Text('Create SmartURL')),
      body: Column(
        children: [
          TextField(onChanged: (value) => url = value),
          ElevatedButton(
            onPressed: () => addURLS(url),
            child: const Text('CREATE !'),
          )
        ],
      ),
    );
  }
}
