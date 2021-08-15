import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const String ordersScreenRoute = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Center(
        child: Text('Orders Screen.'),
      ),
    );
  }
}
