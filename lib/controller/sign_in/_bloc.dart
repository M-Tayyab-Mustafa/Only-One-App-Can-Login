import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../screen/home.dart';
import '../../utils/button.dart';
import '../../utils/constants.dart';
import '../../utils/firebase_push_notifications.dart';

part '_event.dart';
part '_state.dart';

class SignInBloc extends Bloc<SignInScreenEvent, SignInScreenState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  SignInBloc() : super(Loading()) {
    on<Initial>(_initialization);
    on<SignIn>(_signIn);
    on<SignUp>(_signUp);
  }
  Future<void> _initialization(
      Initial event, Emitter<SignInScreenState> emit) async {
    await FirebasePushNotifications().requestPermission().whenComplete(
          () => emit(
            Loaded(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
          ),
        );
  }

  Future<void> _signIn(SignIn event, Emitter<SignInScreenState> emit) async {
    try {
      if (formKey.currentState!.validate()) {
        emit(Loading());
        await firebaseAuth
            .signInWithEmailAndPassword(
          email: emailController.text.toLowerCase(),
          password: passwordController.text,
        )
            .then((userCredential) async {
          DocumentSnapshot documentSnapshot =
              await firebaseFirestore.collection('companies').doc('abc').get();
          String cloudToken = (documentSnapshot.data() as Map)['token'];
          await FirebaseMessaging.instance.getToken().then((token) async {
            if (cloudToken == token) {
              Navigator.pushReplacementNamed(
                  event.context, HomeScreen.screenName);
            } else {
              await showDialog(
                context: event.context,
                builder: (context) => AlertDialog(
                  title: const Text('Already Sign In an other Device'),
                  content: const Text(
                    'You Have Sign In with other Device. Do you want to continue in this device if so then you will be forcefully Sign Out from other device.',
                  ),
                  actions: [
                    CustomButton(
                      title: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                        emit(
                          Loaded(
                            formKey: formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                        );
                      },
                    ),
                    CustomButton(
                      primaryColor: true,
                      title: 'Continue',
                      onPressed: () async {
                        Navigator.pop(context);
                        await http
                            .post(
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization':
                                'key=AAAACqE23qk:APA91bFkz4rBHfCE3PTfeDWX0Guz83JCkH5WMQMe38M6U_Pz5-oNAcLVDs5LomdD2t_aMgNpqtGShomTv9ETfghVHHUsVrzys8WT7vYJ8jnyKzPgFVouG2aC5PpNoSvvjOHlhPHdcHSd',
                          },
                          body: jsonEncode(
                            {
                              'data': const RemoteNotification(
                                android: AndroidNotification(
                                  channelId: 'Sign Out',
                                ),
                                title: 'Sign Out',
                                body: 'You Signed In From an other Device',
                              ).toMap(),
                              "to": cloudToken,
                            },
                          ),
                        )
                            .whenComplete(() async {
                          await firebaseFirestore
                              .collection('companies')
                              .doc('abc')
                              .set({'token': token}).whenComplete(() {
                            Navigator.pushReplacementNamed(
                                event.context, HomeScreen.screenName);
                          });
                        });
                      },
                    ),
                  ],
                ),
              );
            }
          });
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showErrorToast(msg: 'Please check you\'r email or password');
        emit(Loaded(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController));
      } else {
        showErrorToast(msg: 'Some thing went wrong');
        emit(Loaded(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController));
      }
    } catch (exception) {
      log(exception.toString());
      emit(Error());
    }
  }

  Future<void> _signUp(SignUp event, Emitter<SignInScreenState> emit) async {
    try {
      if (formKey.currentState!.validate()) {
        emit(Loading());
        await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseMessaging.instance.getToken().then((token) async {
          await firebaseFirestore
              .collection('companies')
              .doc('abc')
              .set({'token': token}).whenComplete(
            () => Navigator.pushReplacementNamed(
                event.context, HomeScreen.screenName),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorToast(msg: 'User already exist with this email.');
        emit(Loaded(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController));
      } else {
        showErrorToast(msg: 'Some thing went wrong');
        emit(Loaded(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController));
      }
    } catch (exception) {
      showErrorToast(msg: 'Some thing went wrong');
      log(exception.toString());
      emit(Error());
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
