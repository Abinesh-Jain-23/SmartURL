import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

import '../services/url_service.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key, required this.databases});

  final Databases databases;

  addURLS(Map data, BuildContext context) async {
    try {
      await databases.createDocument(
        databaseId: '66693da4001556742582',
        collectionId: '66696cdc000fd5d4b5e2',
        documentId: ID.unique(),
        data: data,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Smart Link Created :)')));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong :()')));
    }
  }

  final urlService = UrlService();
  final Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create SmartURL')),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add url',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.url,
                  onChanged: (value) => [
                    data['fullURL'] = value,
                    data['shortURL'] = value,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Enter URL',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => data['shortCode'] = value,
                  decoration: const InputDecoration(
                    labelText: 'Enter Alias (optional)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => data['description'] = value,
                  decoration: const InputDecoration(
                    labelText: 'Enter Description (optional)',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => addURLS(data, context),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                minimumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 50)),
              ),
              child: const Text(
                'Generate Smart URL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
