import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:textile/config/router/router.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/screens/auth/sign_in.dart';
import 'package:textile/screens/home/Orders.dart';
import 'package:textile/screens/home/homepage.dart';
import 'package:textile/screens/payment_detail_page/total_payment_detail_page.dart';
import 'package:textile/screens/profile.dart';
import 'package:textile/screens/widgets/webview.dart';
import 'package:textile/utils/helpers/utils.dart';
import 'package:textile/utils/palette.dart';

import '../../models/mobile_menu_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
 final List<MenusModel> _menu = <MenusModel>[];

 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   _fetchMenu();
 }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              '${kUserdata?.name?.toUpperCase()}',
              style: TextStyle(fontSize: 12.sp),
            ),
            accountEmail: Text(
              '${kUserdata?.email?.toUpperCase()}  |  ${kUserdata?.type?.toUpperCase()}',
              style: TextStyle(fontSize: 12.sp),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.orange,
              backgroundImage: AssetImage('assets/images/adminicon.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(color: Palette.blackColor.shade500),
            ),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage()));

            },
          ),
          Divider(thickness: 1.0,),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Text(
              'Order',
              style: TextStyle(color: Palette.blackColor.shade500),
            ),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const Orders()));
            },
          ),
          Divider(thickness: 1.0,),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(color: Palette.blackColor.shade500),
            ),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          Divider(thickness: 1.0,),
          ExpansionTile(
              title: Row(
                children: const [
                  Icon(Icons.shopping_bag,color: Colors.grey,),
                  SizedBox(width: 30,),
                  Text('Orders',style: TextStyle(color: Colors.blueGrey),),
                ],
              ),
              children: [
                ListTile(

                title: Text("Create Order",
                    style: TextStyle(color: Palette.blackColor.shade500)),
                onTap: () {
                  Navigator.pop(context, true);
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => const MoreWebview(url: 'https://textileutsav.com/machine/admin/create-order-clone', title: 'Create Orders',)));
                },
              ),
                ListTile(
                  title: Text("View Orders",
                    style: TextStyle(color: Palette.blackColor.shade500)),
                onTap: () {
                  Navigator.pop(context, true);
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => const MoreWebview(url: 'https://textileutsav.com/machine/admin/view-orders-clone', title: 'View Orders',)));
                },
              ),
              ]
          ),
          Divider(thickness: 1.0,),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text("Payment",
                style: TextStyle(color: Palette.blackColor.shade500)),
            onTap: () {
              Navigator.pop(context, true);
              Navigate.to(const PaymentDetailPage());
            },
          ),
          Divider(thickness: 1.0,),
          ExpansionTile(
            title: const Text('Setting'),
            children: [ListTile(
              leading: const Icon(Icons.password),
              title: Text("Change Password",
                  style: TextStyle(color: Palette.blackColor.shade500)),
              onTap: () {
                Utils.showToast('Will be updated soon');
                Navigator.pop(context, true);
              },
            ),]
          ),
          Divider(thickness: 1.0,),
          ExpansionTile(
            title: const Text('Manage'),
            children: _menu.map((menu) {
              if (menu.child != null && menu.child!.isNotEmpty) {
                return ExpansionTile(
                  title: Text("${menu.title}"),
                  children: menu.child!.map((subMenu) {
                    return ListTile(
                      title: Text("${subMenu.title}",
                          style: const TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.pop(context, true);
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => MoreWebview(url: subMenu.link!, title: subMenu.title,)));
                      },
                    );
                  }).toList(),
                );
              } else {
                return ListTile(
                  title: Text("${menu.title}",
                      style: const TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigate.close(true);
                    Navigate.to(MoreWebview(title: menu.title, url: menu.link!));
                    // Navigator.push(context, CupertinoPageRoute(builder: (_) => MoreWebview(url: menu.link!, title: menu.title,)));
                  },
                );
              }
            }).toList(),
          ),
          Divider(thickness: 1.0,),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Logout",
                style: TextStyle(color: Palette.blackColor.shade500)),
            onTap: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const SignIn()));
            },
          ),
        ],
      ),
    );
  }
   void _fetchMenu() async {
   final response = await http
       .get(Uri.https('textileutsav.com', 'machine/api/get-mobile-menus'));
   if (response.statusCode == 200) {
     final jsonData = jsonDecode(response.body);
     jsonData['menus'].forEach((v) {
       _menu.add(MenusModel.fromJson(v));
     });
   }
   setState(() {});
 }
}
