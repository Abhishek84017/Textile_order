import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:intl/intl.dart';
import 'package:textile/constants/app_assets.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/models/data_model.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';
import 'package:textile/screens/widgets/drawer.dart';
import 'package:textile/screens/widgets/input.dart';
import 'package:textile/utils/helpers/utils.dart';
import 'package:textile/utils/palette.dart';
import 'package:textile/utils/services/rest_api.dart';
import 'package:http/http.dart' as http;

import '../../models/PaymentDetailByIdModel.dart';

class PaymentDetailPageById extends StatefulWidget {

   final int? id;
   final String? partyName;
   const PaymentDetailPageById({Key? key,this.id,this.partyName}) : super(key: key);

  @override
  State<PaymentDetailPageById> createState() => _PaymentDetailPageByIdState();
}

class _PaymentDetailPageByIdState extends State<PaymentDetailPageById> {

  final TextEditingController _rupees = TextEditingController();
  final TextEditingController _remark = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.partyName ?? ''),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      drawer: const DrawerWidget(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.loginBackground,
            fit: BoxFit.fill,
          ),
          FutureBuilder<Data<List<PaymentDetailByIdModel>>>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppProgressIndicator(
                    color: Palette.primaryColor);
              }
              if (snapshot.hasData &&
                  snapshot.data!.statusCode == 200 &&
                  snapshot.data!.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.data![index];
                      return Padding(
                        padding: EdgeInsets.all(20.w),
                        child: GestureDetector(
                          child: Card(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            elevation: 10,
                            shadowColor: Palette.primaryColor.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Bill Amount'),
                                      Text('${order.billAmount}'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Pending Amount'),
                                      Text('${order.pending}')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('received'),
                                      Text('${order.received}')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Last Update Date'),
                                      Text(DateFormat("dd-MM-yyyy hh:mm a")
                                          .format(DateTime.tryParse(
                                          "${order.modified}") ??
                                          DateTime.now())),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await showCupertinoDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children:  [
                                                    Input(hintText:'Enter Rupees',controller: _rupees,keyBoardType: TextInputType.number,),
                                                    Input(hintText: 'Remark',controller: _remark,),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child:
                                                    const Text('Save'),
                                                    onPressed: (){
                                                      if(_rupees.text.isEmpty)
                                                      {
                                                        Utils.showToast('Enter Rupees');
                                                        return;
                                                      }
                                                      if(_remark.text.isEmpty)
                                                      {
                                                        Utils.showToast('Enter Rupees');
                                                        return;
                                                      }
                                                      _makeAsPaid(order);
                                                      Navigator.pop(context,true);
                                                      _rupees.clear();
                                                      _remark.clear();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('No'),
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, false),
                                                  ),
                                                ],
                                              ));
                                        },
                                        child: Text(
                                          'Make a Payment',
                                          style: TextStyle(
                                              color:
                                              Palette.primaryColor.shade900),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await showCupertinoDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Are You Sure'),
                                                actions: [
                                                  TextButton(
                                                    child:
                                                    const Text('Yes'),
                                                    onPressed: (){
                                                      _closed(order);
                                                      Navigator.pop(context,true);
                                                      setState(() {});
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('No'),
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, false),
                                                  ),
                                                ],
                                              ));
                                        },
                                         child: const Text(
                                          'Mark As Inactive',
                                          style: TextStyle(
                                              color:
                                              Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("Data not found"),
                );
              }
            },
            future: Services.getPaymentByPartyId(widget.id),
          ),
        ],
      ),
    );
  }

  void _makeAsPaid(PaymentDetailByIdModel order) async {
    var data = <String,dynamic>
    {
      "payment_id" : order.id.toString(),
      "user_id" : kUserdata?.id.toString(),
      "amount" : _rupees.text,
      "remark" : _remark.text
    };
    final response = await http.post(Uri.https('textileutsav.com', 'machine/api/make-a-payment'),body:data);
    try{
      if(response.statusCode == 200){
        print(response.body);
        final jsonData = jsonDecode(response.body);
        Utils.showToast(jsonData['message']);
        setState(() {

        });
      }
    }catch(_){
      Utils.showToast('Something Went Wrong');
    }
  }

  void _closed(PaymentDetailByIdModel order) async {
    final response = await http.get(Uri.https('textileutsav.com', 'machine/api/mark-as-closed/${order.id}'));
    print(response.request);
    try{
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        Utils.showToast(jsonData['message']);
        setState(() {
        });
      }
    }catch(_){
      Utils.showToast('Something Went Wrong');
    }
  }

}




