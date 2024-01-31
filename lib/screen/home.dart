import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/controller/home/_bloc.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/utils/button.dart';

import '../utils/firebase_push_notifications.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String screenName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    homeBuildContext = context;
    return Scaffold(
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: 'Sign Out',
                  onPressed: () => BlocProvider.of<HomeScreenBloc>(context).add(
                    SignOut(context: context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
