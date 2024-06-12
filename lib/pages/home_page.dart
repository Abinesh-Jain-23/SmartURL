import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class HomePage extends StatefulWidget {
  final Account account;
  final Databases databases;

  const HomePage({
    super.key,
    required this.account,
    required this.databases,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final baseURL = "https://node-js-nw38.onrender.com/";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart URL')),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: widget.databases.listDocuments(
              databaseId: '66693da4001556742582',
              collectionId: '66696cdc000fd5d4b5e2',
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
                      final item = data[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          onTap: () async {
                            Navigator.of(context).pushNamed(
                              '/view',
                              arguments: {
                                'urlData': data[index].data,
                                'id': item.$id,
                              },
                            );
                          },
                          leading: const Icon(Icons.link),
                          title: Text(
                            '${data[index].data['fullURL']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '$baseURL${data[index].$id}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed('/add')
            .then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
