import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:qr_flutter/qr_flutter.dart';

class ViewPage extends StatelessWidget {
  final Account account;
  final Databases databases;
  final baseURL = "https://node-js-nw38.onrender.com/";

  const ViewPage({
    super.key,
    required this.account,
    required this.databases,
  });

  Future<void> triggerlaunchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final short = '$baseURL${arguments['id']}';
    return Scaffold(
      appBar: AppBar(title: const Text('Smart URL')),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: QrImageView(
                  data: short,
                  version: QrVersions.auto,
                ),
              ),
              IconButton.filled(
                onPressed: () async =>
                    await Clipboard.setData(ClipboardData(text: short)),
                icon: const Icon(Icons.copy),
              ),
              const SizedBox(height: 12),
              IconButton.filled(
                onPressed: () => triggerlaunchUrl(short),
                icon: const Icon(Icons.launch),
              ),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Smart URL !',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        short,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const Divider(),
                      const Text(
                        'Actual URL :(',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '${arguments['urlData']['fullURL']}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
