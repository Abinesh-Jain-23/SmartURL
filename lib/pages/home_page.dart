import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Account account;
  final Databases databases;

  const HomePage({
    super.key,
    required this.account,
    required this.databases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart URL')),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: databases.listDocuments(
              databaseId: '66693da4001556742582',
              collectionId: '666942ae001eeafa098c',
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final data = snapshot.data?.documents ?? [];
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${data[index].data['fullURL']}'),
                        subtitle: Text('${data[index].data['shortURL']}'),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
