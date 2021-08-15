import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_cubit/register_cubit.dart';
import 'package:shop_app/modules/register/register_cubit/register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  static const String registerScreenRoute = '/register';
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              token = state.registerModel.registerDataModel!.token;
              showToast(message: state.registerModel.message);
              CacheHelper.insertData(
                      key: 'token',
                      value: state.registerModel.registerDataModel!.token)
                  .then((value) {
                print(state.registerModel.registerDataModel!.token);
                Navigator.of(context).pushReplacementNamed(
                  ShopLayout.shopLayoutRoute,
                );
              });
            } else {
              showToast(message: state.registerModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3,
                              ),
                            ],
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          'Join our community now, and ENJOY!',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          label: 'Full Name',
                          helper: 'ex: John Wick',
                          prefix: Icons.person,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'name can not be empty.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: 'Email Address',
                          helper: 'example@company.com',
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'email address can not be empty.';
                            } else {
                              if (!value.contains('@'))
                                return 'wrong email address format.';
                              else if (!value.contains('.'))
                                return 'wrong email address format.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          label: 'Password',
                          helper: 'must be at least 6 digits.',
                          prefix: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password can not be empty.';
                            } else if (value.length < 6) {
                              return 'password is too short.';
                            }
                          },
                          isPassword: cubit.isPassword,
                          suffix: cubit.isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixPressed: () {
                            cubit.changeTextFormEditingToPassword();
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          label: 'Phone Number',
                          helper: 'ex: 01xxxxxxxxx',
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'name can not be empty.';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! RegisterLoadingState,
                          widgetBuilder: (context) => buildMainButton(
                            label: 'REGISTER',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.registerNewUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurpleAccent),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account?",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  LoginScreen.loginScreenRoute,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
