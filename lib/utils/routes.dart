import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/controller/home/_bloc.dart';

import '../controller/sign_in/_bloc.dart';
import '../screen/home.dart';
import '../screen/sign_in.dart';

class Routes {
  static Route _route(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.screenName:
        return _route(
          BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInScreen(),
          ),
        );
      case HomeScreen.screenName:
        return _route(BlocProvider(
          create: (context) => HomeScreenBloc(),
          child: const HomeScreen(),
        ));
      default:
        return _route(const ErrorScreen());
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  static const String screenName = 'error_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Some Thing Went Wrong'),
      ),
    );
  }
}
