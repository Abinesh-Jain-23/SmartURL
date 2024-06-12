import 'package:flutter/material.dart';
import 'package:smarturl/src/app.dart';
import 'package:appwrite/appwrite.dart';

void main() async {

Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('6666e8f90025c5f4662c')
      .setSelfSigned(status: true);
  Account account = Account(client);
  Databases databases = Databases(client);
  runApp(App(
    account: account,
    databases: databases,
  ));
}


