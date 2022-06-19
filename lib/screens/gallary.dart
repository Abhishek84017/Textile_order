import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textile/screens/imageview.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';
import 'package:textile/screens/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';


import '../models/gallary_model.dart';


class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key, this.mobile}) : super(key: key);
  final String? mobile;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  final List<GalleryModel> GalleryData = <GalleryModel>[];

  Future<List<GalleryModel>> _fetchGalleryPageData() async {
    GalleryData.clear();
    final response = await http.get(
        Uri.parse("http://www.textileutsav.com/machine/api/get-all-designs"));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            GalleryData.add(GalleryModel.fromJson(v));

          });
        }
      }
    } on SocketException catch (error) {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return GalleryData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GalleryModel>>(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Gallery'),
            ),
            drawer: const DrawerWidget(),
            body: GridView.builder(
                itemCount: GalleryData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? 3
                        : 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.w,
                    childAspectRatio: (2 / 1.3)),
                itemBuilder: (context, index) {
                  var item = GalleryData[index];
                  return Card(
                      shadowColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.w),
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => ImageViewer(image: '${item.image}')));
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(seconds: 1),
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                    imageUrl: 'https://www.textileutsav.com/machine/${item.image}',
                                  progressIndicatorBuilder: (context, url, downloadProgress) => const AppProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Text('Code: ${item.code.toString()}'),
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
      future: _fetchGalleryPageData(),
    );
  }


}
