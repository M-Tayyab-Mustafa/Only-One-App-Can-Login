// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screen/sign_in.dart';

part '_event.dart';
part '_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(Loading()) {
    on<Initial>(_initialization);
    on<SignOut>(_signOut);
  }
  Future<void> _initialization(
      Initial event, Emitter<HomeScreenState> emit) async {
    _loaded;
  }

  Future<void> _signOut(SignOut event, Emitter<HomeScreenState> emit) async {
    try {
      _loading;
      await FirebaseAuth.instance.signOut().whenComplete(
            () => Navigator.pushReplacementNamed(
                event.context, SignInScreen.screenName),
          );
    } catch (e) {
      log(e.toString());
      _error;
    }
  }

  get _loading => emit(Loading());
  get _loaded => emit(Loaded());
  get _error => emit(Error());
}
