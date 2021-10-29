// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/layouts/social_app/social_Layout.dart';
import 'package:messenger/modules/social_app_modules/social_login_screen/social_login_screen.dart';
import 'package:messenger/shared/components/components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('no user');
        NavigateToreplace(context, SocialLayout());
      } 
    });
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
