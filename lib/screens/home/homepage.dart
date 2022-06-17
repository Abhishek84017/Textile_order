import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textile/models/home_page_model.dart';
import 'package:textile/screens/home/Orders.dart';
import 'package:textile/screens/notes.dart';
import 'package:textile/screens/payment_detail_page/total_payment_detail_page.dart';
import 'package:textile/screens/widgets/webview.dart';
import '../../config/router/router.dart';
import '../../utils/helpers/utils.dart';
import '../gallary.dart';
import '../widgets/drawer.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.mobile}) : super(key: key);
  final String? mobile;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _currentBackPressTime;



  final List<HomePageModel> _CardData = <HomePageModel>[];

  Future<bool> _onBackPress() async {
    return await showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
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

  Future<List<HomePageModel>> _fetchHomePageData() async {
    _CardData.clear();
    final response = await http.get(
        Uri.parse("https://www.textileutsav.com/machine/api/get-home-cards"));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            _CardData.add(HomePageModel.fromJson(v));

          });
        }
      }
    } on SocketException catch (error) {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } catch (e) {
        print(e.toString());
    }
    return _CardData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HomePageModel>>(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return WillPopScope(
            onWillPop: _onBackPress,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
              ),
              drawer: const DrawerWidget(),
              body: GridView.builder(
                  itemCount: _CardData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 3
                          : 2,
                      crossAxisSpacing: 1.w,
                      mainAxisSpacing: 1.w,
                      childAspectRatio: (2 / 1.3)),
                  itemBuilder: (context, index) {
                    var item = _CardData[index];
                    return Card(
                        shadowColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.w),
                          onTap: () {
                            if(item.type == 'web')
                              {
                                Navigator.push(context, CupertinoPageRoute(builder: (_) => MoreWebview(title: item.title, url: item.value!)));
                              }
                            else if(item.type == 'custom'){
                              if(item.value == 'payment')
                                {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const PaymentDetailPage()));
                                }
                              if(item.value == 'order' )
                                {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const Orders()));
                                }
                              if(item.value == 'all_notes')
                                {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const NotesPage()));
                                }
                              if(item.value == 'all_designs')
                                {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const GalleryPage()));
                                }
                              if(item.value == 'changepassword')
                              {
                                Fluttertoast.showToast(msg: 'Update shortly');
                              }
                            }
                            },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: FadeInImage.assetNetwork(
                                    height: 100,
                                    width: 100,
                                    placeholder: 'assets/images/adminicon.png',
                                    image: 'https://www.textileutsav.com/machine/${item.image}'),
                              ),
                              Text(item.title.toString()),
                            ],
                          ),
                        ));
                  }),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _fetchHomePageData(),
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
