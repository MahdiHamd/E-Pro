import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/pro_layout.dart';
import '../../../shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToastNew(context, state.error);
          }
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, ProLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              color: Colors.deepOrange,
              width: double.infinity,
              height: 650,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          //margin: EdgeInsets.only(top: 30),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/register.png"),
                            ),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            // shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'REGISTER',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your name';
                                    }
                                  },
                                  label: 'User Name',
                                  prefix: Icons.person,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your email address';
                                    }
                                  },
                                  label: 'Email Address',
                                  prefix: Icons.email_outlined,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  suffix: RegisterCubit.get(context).suffix,
                                  onSubmit: (value) {},
                                  isPassword:
                                      RegisterCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    RegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  validate: (value) {
                                    RegExp regex = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if (value!.isEmpty) {
                                      return 'Please enter password';
                                    } else {
                                      if (!regex.hasMatch(value)) {
                                        return 'Enter valid password';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: confirmpasswordController,
                                  type: TextInputType.visiblePassword,
                                  suffix: RegisterCubit.get(context).suffix,
                                  onSubmit: (value) {},
                                  isPassword:
                                      RegisterCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    RegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  validate: (value) {
                                    if (confirmpasswordController.text !=
                                        passwordController.text) {
                                      return '  Password do not match';
                                    }
                                  },
                                  label: 'ConfirmPassword',
                                  prefix: Icons.lock_outline,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      String pattern =
                                          r'(^(?:[+0]9)?[0-9]{10}$)';
                                      RegExp regExp = new RegExp(pattern);
                                      if (value.length == 0) {
                                        return 'Please enter mobile number';
                                      } else if (!regExp.hasMatch(value)) {
                                        return 'Please enter valid mobile number';
                                      }
                                      return null;
                                    }
                                  },
                                  label: 'Phone',
                                  prefix: Icons.phone,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                ConditionalBuilderRec(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: 'register',
                                    isUpperCase: true,
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
