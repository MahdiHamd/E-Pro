// ignore_for_file: unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/modules/pro_app/register_social/cubit/cubit.dart';
import 'package:my_project/shared/components/constants.dart';
import 'package:my_project/shared/cubit/cubit.dart';
import 'package:my_project/shared/cubit/states.dart';
import 'package:my_project/shared/styles/themes.dart';

import 'layout/pro_app/cubit/cubit.dart';
import 'layout/pro_app/pro_layout.dart';
import 'modules/pro_app/login_social/login_pro_screen.dart';
import 'modules/pro_app/onboarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';

Widget? widget;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();

      bool? isDark = CacheHelper.getData(key: 'isDark');
      bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
      uId = CacheHelper.getData(key: 'uId');

      if (onBoarding != null) {
        if (uId != null) {
          widget = ProLayout();
        } else {
          widget = LoginScreen();
        }
      } else {
        widget = const OnBoardingScreen();
      }

      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProCubit()
            ..getUserData()
            ..getCategories()
            ..getPracts()
            ..getUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
