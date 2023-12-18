import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/sign_in.dart';
import 'main_components/main_specialty_page.dart';


class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            print(snapshot.data);

            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainSpecialtyPage(),
                  ),
                );
          }
          print('No data');
          return SignIn();
        });
  }
}
