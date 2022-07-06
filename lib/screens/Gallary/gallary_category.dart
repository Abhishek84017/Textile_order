import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textile/models/gallery_category_model.dart';
import 'package:textile/screens/widgets/drawer.dart';
import 'package:textile/utils/services/rest_api.dart';
import 'gallary.dart';


class GalleryCategoryPage extends StatefulWidget {

  const GalleryCategoryPage({Key? key,}) : super(key: key);


  @override
  _GalleryCategoryPageState createState() => _GalleryCategoryPageState();
}

class _GalleryCategoryPageState extends State<GalleryCategoryPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
        ),
        drawer: const DrawerWidget(),
    body : FutureBuilder<List<GalleryCategoryModel>>(
      builder: (BuildContext context,  snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          }
        if(snapshot.hasError)
          {
            Fluttertoast.showToast(msg: 'Something Went Wrong');
          }
        if (snapshot.hasData) {
          return  GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
                    crossAxisSpacing: 1.w,
                    mainAxisSpacing: 1.w,
                    childAspectRatio: (2 / 1.3)),
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return Card(
                      shadowColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.w),
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) =>   GalleryPage(id: item.id,type: item.title,)));
                        },
                        child: Center(child: Text("${item.title}"),),
                      ));
                });

        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: Services().fetchGalleryPageData(),
    ));
  }


}
