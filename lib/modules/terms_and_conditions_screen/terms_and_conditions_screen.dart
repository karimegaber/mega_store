import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  static const String termsAndConditionsScreen = '/terms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: double.infinity,
        child: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            wordSpacing: 5,
          ),
          maxLines: 50,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
