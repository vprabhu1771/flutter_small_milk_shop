import 'package:flutter/material.dart';

import '../screens/ProductScreen.dart';
import '../screens/auth/LoginScreen.dart';
import '../screens/cart/CartScreen.dart';
import '../screens/order/OrderScreen.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Products'),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(title: 'Products'),
                ),
              );

            },
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(title: 'Cart'),
                ),
              );

            },
          ),
          ListTile(
            title: const Text('Orders'),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(title: 'Orders'),
                ),
              );

            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {

              Navigator.pop(context);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(title: 'Login'),
                ),
              );


            },
          ),
        ],
      ),
    );
  }
}