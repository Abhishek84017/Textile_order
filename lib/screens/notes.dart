import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textile/models/home_page_model.dart';
import 'package:textile/models/notes_model.dart';
import 'package:textile/screens/widgets/drawer.dart';

import '../../config/router/router.dart';
import '../../utils/helpers/utils.dart';
import 'package:http/http.dart' as http;


class NotesPage extends StatefulWidget {
  const NotesPage({Key? key, this.mobile}) : super(key: key);
  final String? mobile;

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  DateTime? _currentBackPressTime;



  final List<NotesModel> _CardData = <NotesModel>[];



  Future<List<NotesModel>> _fetchNotesPageData() async {
    _CardData.clear();
    final response = await http.get(
        Uri.parse("http://www.textileutsav.com/machine/api/get-all-notes"));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            _CardData.add(NotesModel.fromJson(v));
            print(_CardData.length);
          });
        }
      }
    } on SocketException catch (error) {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return _CardData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotesModel>>(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
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
                        onTap: () {},
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _fetchNotesPageData(),
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
