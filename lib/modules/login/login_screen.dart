import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  static const String loginScreenRoute = '/login';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              token = state.loginModel.data!.token;
              showToast(message: state.loginModel.message);
              CacheHelper.insertData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                print(state.loginModel.data!.token);
                Navigator.of(context).pushReplacementNamed(
                  ShopLayout.shopLayoutRoute,
                );
              });
            } else {
              showToast(message: state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
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
                          'LOGIN',
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
                          'login now to browse our hot offers.',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                          isPassword: loginCubit.isPassword,
                          suffix: loginCubit.isPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixPressed: () {
                            loginCubit.changeTextFormEditingToPassword();
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: loginCubit.rememberMe,
                              onChanged: (value) {
                                loginCubit.changeRememberMeCheckBox();
                              },
                            ),
                            InkWell(
                              child: Text(
                                'Remember me',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              onTap: () {
                                loginCubit.changeRememberMeCheckBox();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! LoginLoadingState,
                          widgetBuilder: (context) => buildMainButton(
                            label: 'LOGIN',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(
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
                              "don't have an account?",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  RegisterScreen.registerScreenRoute,
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
