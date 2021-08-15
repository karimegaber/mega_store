import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  String? helper = '',
  IconData? prefix,
  IconData? suffix,
  required TextInputType type,
  String? Function(String?)? validate,
  bool isPassword = false,
  void Function()? suffixPressed,
  TextStyle? labelStylee,
  void Function(String)? onSubmit,
}) {
  return TextFormField(
    controller: controller,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: labelStylee,
      helperText: '$helper',
      prefixIcon: Icon(
        prefix,
        color: Colors.deepPurple,
      ),
      suffixIcon: IconButton(
        icon: Icon(suffix),
        color: Colors.deepPurpleAccent,
        onPressed: suffixPressed,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: Colors.deepPurpleAccent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.deepPurple.withOpacity(0.5),
          width: 2.0,
        ),
      ),
    ),
    obscureText: isPassword,
    keyboardType: type,
    validator: validate,
  );
}

Widget buildMainButton({
  double? size = double.infinity,
  required String label,
  required void Function() onPressed,
  Color? textColor,
  Color? buttonColor,
}) {
  return Container(
    width: size,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        padding: EdgeInsets.all(20.0),
        elevation: 10,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
  );
}

Widget buildAddToCartButton({
  double? size = double.infinity,
  required String label,
  required void Function() onPressed,
}) {
  return Container(
    width: size,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20.0),
        elevation: 10,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(label),
        ],
      ),
    ),
  );
}

Widget buildDivider() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2.0,
          width: 150.0,
          color: Colors.grey,
        ),
        Text(
          ' OR ',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 2.0,
          width: 150.0,
          color: Colors.grey,
        ),
      ],
    );

void showToast({
  required String message,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget seeAll({
  required void Function() onPressed,
  required String title,
}) =>
    InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'See all',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
