import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/screen/sign_in.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/utils/routes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SignInScreen.screenName,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
