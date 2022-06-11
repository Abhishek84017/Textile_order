import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/router/router.dart';
import '../../utils/helpers/utils.dart';
import '../widgets/drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.mobile}) : super(key: key);
  final String? mobile;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime? _currentBackPressTime;

  final List<String> name = [
    "Comity Details",
    "Member Details",
    'Search Occupation',
    'Add Member',
    "Send Notification",
    'Send Whatsapp',
    'Send Message',
  ];





  Future<bool> _onBackPress() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you want to exit the application'),
          actions: [
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
                FocusScope.of(context).unfocus();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const DrawerWidget(),
        body: GridView.builder(
            itemCount: name.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 3
                    : 2,
                crossAxisSpacing: 1.w,
                mainAxisSpacing: 1.w,
                childAspectRatio: (2 / 1.3)),
            itemBuilder: (context, index) {
              var item =  name[index] ;
              return Card(
                  shadowColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.w),
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       const Icon(Icons.verified_user,color: Colors.blueGrey,),
                        Text(index.toString()),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Utils.showToast('Press again to exit');
      return Future.value(false);
    }
    Navigate.close();
    return Future.value(false);
  }
}