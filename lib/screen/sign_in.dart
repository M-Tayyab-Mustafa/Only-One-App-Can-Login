import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/utils/button.dart';
import 'package:only_one_device_can_login_at_a_time_using_firebase/utils/routes.dart';

import '../controller/sign_in/_bloc.dart';
import '../utils/text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String screenName = 'sign_in_screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignInBloc>(context).add(Initial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInScreenState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (Loading):
              return const Center(child: CircularProgressIndicator.adaptive());
            case const (Loaded):
              state as Loaded;
              return Form(
                key: state.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomEmailTextField(
                      controller: state.emailController,
                    ),
                    CustomPasswordTextField(
                      controller: state.passwordController,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          primaryColor: true,
                          title: 'Sign In',
                          onPressed: () => BlocProvider.of<SignInBloc>(context)
                              .add(SignIn(context: context)),
                        ),
                        CustomButton(
                          primaryColor: true,
                          title: 'Sign Up',
                          onPressed: () => BlocProvider.of<SignInBloc>(context)
                              .add(SignUp(context: context)),
                        ),
                      ],
                    )
                  ],
                ),
              );
            default:
              state as Error;
              return const ErrorScreen();
          }
        },
      ),
    );
  }
}
