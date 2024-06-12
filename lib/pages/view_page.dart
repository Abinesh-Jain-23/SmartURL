import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewPage extends StatelessWidget {
  final Account account;
  final Databases databases;

  const ViewPage({
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    print(arguments['urlData']);
    return Scaffold(
      appBar: AppBar(title: const Text('Smart URL')),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: QrImageView(
                  data: arguments['urlData']['fullURL'],
                  version: QrVersions.auto,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      Text(
                        '${arguments['urlData']['shortURL']}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Divider(),
                      Text(
                        '${arguments['urlData']['fullURL']}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
