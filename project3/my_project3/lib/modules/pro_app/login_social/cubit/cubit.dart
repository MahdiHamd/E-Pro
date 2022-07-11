import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/pro_app/login_social/cubit/state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  //LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print(value.user!.email);
        print(value.user!.uid);
        emit(LoginSuccessState(value.user!.uid));
      });
    } on FirebaseAuthException catch (erorr) {
      String message = "The Email is Wrong";

      if (erorr.code == "email-already-in-use") {
        message = message = "${erorr.code}";
        ;
      } else if (erorr.code == "wrong-password") {
        message = "wrong password provided for that user";
      }

      emit(LoginErrorState(message));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}
