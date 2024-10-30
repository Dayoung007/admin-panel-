import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/uploade_banners_screen.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:tofunmi_ecommerce_web_admin/views/screens/side_bar_screens/withdrawal_screen.dart';

import 'side_bar_screens/orders_screen.dart';
import 'side_bar_screens/product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = const DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = const DashboardScreen();
        });
        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = const VendorsScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = const WithdrawalScreen();
        });
        break;
      case OrderScreen.routeName:
        setState(() {
          _selectedItem = const OrderScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = const CategoriesScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedItem = const ProductScreen();
        });
        break;
      case UploadBannersScreen.routeName:
        setState(() {
          _selectedItem = const UploadBannersScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Management'),
      ),
      body: _selectedItem,
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.routeName,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: WithdrawalScreen.routeName,
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoriesScreen.routeName,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Upload banner',
            route: UploadBannersScreen.routeName,
            icon: CupertinoIcons.add,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Tofunmi Admin Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'copyright Tofunmi',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
