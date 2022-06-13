import 'package:businessmanagementsoftware/screens/add_product.dart';
import 'package:businessmanagementsoftware/screens/add_sale.dart';
import 'package:businessmanagementsoftware/screens/product_details.dart';
import 'package:businessmanagementsoftware/screens/sale_history.dart';
import 'package:flutter/material.dart';

Widget drawerWidget(BuildContext context) => Drawer(
      backgroundColor: Colors.brown,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/demo.jpg"),
                  fit: BoxFit.fill,
                  opacity: 0.4),
            ),
            child: Center(
              child: Text(
                'Mihad Mobile store',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Add Product",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                  (route) => false);
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Product Details',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProductDetails()),
                  (route) => false);
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Add Sale',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AddSale()),
                      (route) => false);
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Sale History',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SaleHistory()),
                      (route) => false);
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
