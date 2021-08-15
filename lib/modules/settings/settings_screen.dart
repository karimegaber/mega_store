import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/about_us_screen/about_us_screen.dart';
import 'package:shop_app/modules/orders_screen/orders_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();

    List settings = [
      {
        'name': 'Orders',
        'icon': Icons.shopping_bag,
        'function': OrdersScreen.ordersScreenRoute,
      },
      {
        'name': 'About us',
        'icon': Icons.info_outlined,
        'function': AboutUsScreen.aboutUsScreen,
      },
      {
        'name': 'Terms and conditions',
        'icon': Icons.list,
        'function': TermsAndConditions.termsAndConditionsScreen,
      },
    ];
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel.data!.name;
        phoneController.text = ShopCubit.get(context).userModel.data!.phone;
        emailController.text = ShopCubit.get(context).userModel.data!.email;
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProfileScreen.profileScreenRoute,
                );
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.deepPurple,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 4,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildSettingsIteam(
                    settings[index]['name'], settings[index]['icon'], () {
                  Navigator.of(context).pushNamed(
                    settings[index]['function'],
                  );
                }),
                separatorBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: settings.length,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildMainButton(
                  label: 'Signout',
                  buttonColor: Colors.deepPurpleAccent,
                  onPressed: () {
                    signOut(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        );
      },
    );
  }
}

Widget buildSettingsIteam(String name, IconData icon, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.deepPurple,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
