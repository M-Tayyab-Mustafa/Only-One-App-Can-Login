import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/screen/sign_in.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/utils/button.dart';

import '../utils/firebase_push_notifications.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String screenName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    homeBuildContext = context;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Sign Out',
              onPressed: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() =>
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.screenName));
              },
            ),
          ],
        ),
      ),
    );
  }
}
