import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textile/screens/payment_detail_page/total_payment_detail_page.dart';
import 'package:textile/screens/widgets/drawer.dart';
import 'package:textile/utils/services/rest_api.dart';
import '../../models/all_firm_model.dart';
import '../../utils/palette.dart';




class AllFirms extends StatefulWidget {

  const AllFirms({Key? key,}) : super(key: key);


  @override
  _AllFirmsState createState() => _AllFirmsState();
}

class _AllFirmsState extends State<AllFirms> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firms'),
        ),
        drawer: const DrawerWidget(),
        body : FutureBuilder<List<AllFirmsModel>>(
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
                return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                separatorBuilder: (_, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    elevation: 10,
                    shadowColor: Palette.primaryColor.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => PaymentDetailPage(id: item.id))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      title: Text('${item.title}'),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text('No Firms Found'),
              );
            }
          },
          future: Services().fetchAllFirms(),
        ));
  }
}
