import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  static const String profileScreenRoute = '/profile';

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel.data!.name;
        phoneController.text = ShopCubit.get(context).userModel.data!.phone;
        emailController.text = ShopCubit.get(context).userModel.data!.email;
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurpleAccent),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/user_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ShopCubit.get(context).userModel.data!.name}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            '@${ShopCubit.get(context).userModel.data!.name.replaceAll(' ', '').toLowerCase()}',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      defaultFormField(
                        controller: nameController,
                        label: 'Name',
                        prefix: Icons.person,
                        type: TextInputType.name,
                        labelStylee: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      defaultFormField(
                        controller: emailController,
                        label: 'Email Address',
                        prefix: Icons.email,
                        type: TextInputType.emailAddress,
                        labelStylee: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      defaultFormField(
                        controller: phoneController,
                        label: 'Phone Number',
                        prefix: Icons.phone,
                        type: TextInputType.phone,
                        labelStylee: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  buildMainButton(
                    label: 'Update',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (state is ShopLoadingUpdateProfileDataState)
                    LinearProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
