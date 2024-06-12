import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:smarturl/pages/add_page.dart';
import 'package:smarturl/pages/auth_page.dart';
import 'package:smarturl/pages/home_page.dart';
import 'package:smarturl/pages/view_page.dart';

class App extends StatelessWidget {
  const App({super.key, required this.account, required this.databases});
  final Account account;
  final Databases databases;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(account: account),
        '/home': (context) => HomePage(
              account: account,
              databases: databases,
            ),
        '/add': (context) => AddPage(databases: databases),
        '/view': (context) => ViewPage(
              account: account,
              databases: databases,
            ),
      },
    );
  }
}
