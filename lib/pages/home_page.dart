import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  final Account account;
  final Databases databases;

  const HomePage({
    super.key,
    required this.account,
    required this.databases,
  });

  Future<void> triggerlaunchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart URL')),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: databases.listDocuments(
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
                      print(data[index].data);
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: const BoxDecoration(color: Colors.white, 
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          onTap: () async {
                          Navigator.of(context).pushNamed('/view',  arguments: {'urlData': data[index].data},);
                          },
                          leading: SvgPicture.asset(
                            "/qr.svg",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text('${data[index].data['fullURL']}', maxLines: 1, overflow: TextOverflow.ellipsis,),
                          subtitle: Text('${data[index].data['shortURL']}', maxLines: 1, overflow: TextOverflow.ellipsis,),
                        ),
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
