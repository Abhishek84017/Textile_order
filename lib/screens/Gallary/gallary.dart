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
import 'package:textile/screens/widgets/input.dart';

import '../../models/gallary_model.dart';





class GalleryPage extends StatefulWidget {
  final int? id;
  final String? type;
  const GalleryPage({Key? key, this.id,this.type}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  final List<GalleryModel> GalleryData = <GalleryModel>[];
  List<GalleryModel> searchGalleryData = <GalleryModel>[];
  final TextEditingController _controller = TextEditingController();

  Future<List<GalleryModel>> _fetchGalleryPageData() async {
    final response = await http.get(Uri.parse("http://www.textileutsav.com/machine/api/get-all-designs/${widget.id}"));
    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['data'] != null) {
          jsonData['data'].forEach((v) {
            GalleryData.add(GalleryModel.fromJson(v));
          });
        }
        setState((){});
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return GalleryData;
  }


  void filterFunction(String code)
  {

    searchGalleryData = GalleryData.where((element) => element.code  == _controller.text).toList();
    setState((){});
  }

  @override
  void initState()
  {
    _fetchGalleryPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.type}'),
      ),
      drawer: const DrawerWidget(),
      body: GalleryData.isNotEmpty ? Column(
        children: [
          Input(
            keyBoardType: TextInputType.number,
            controller: _controller,
            hintText: 'Enter Image Code',
            onChange:(value) => filterFunction(value),
          ),
          Expanded(
            child: searchGalleryData.isEmpty ? GridView.builder(
                itemCount: GalleryData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
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
                                  fadeInDuration: const Duration(seconds: 1),
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
                }) : GridView.builder(
                itemCount: searchGalleryData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.w,
                    childAspectRatio: (2 / 1.3)),
                itemBuilder: (context, index) {
                  var item = searchGalleryData[index];
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
                                  fadeInDuration: const Duration(seconds: 1),
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
                }) ),

        ],
      ) : const Center(child: Text('No Image Found'),),
    );
  }
}