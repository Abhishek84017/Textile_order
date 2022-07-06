import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:textile/constants/app_assets.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/models/payment_detail_model.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';
import 'package:textile/screens/widgets/drawer.dart';
import 'package:textile/utils/helpers/utils.dart';
import 'package:textile/utils/palette.dart';
import 'package:http/http.dart' as http;

import 'getpayment_by_party_id.dart';

class PaymentDetailPage extends StatefulWidget {
  final int? id;
  const PaymentDetailPage({Key? key,this.id}) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  final _controller = StreamController<String>();

  List<PaymentDetailModel> payment = <PaymentDetailModel>[];

  Future<List<PaymentDetailModel>> getActivePayment() async {
      print('hello');
    try {
      http.Response response = await http.get(Uri.parse("https://www.textileutsav.com/machine/api/get-party-payment/${widget.id}"));
      payment.clear();
      final jsonResponse = jsonDecode(response.body);
      _controller.sink.add(jsonResponse['pending']);
      if (response.statusCode == 200) {
        if (jsonResponse['data'] != null) {
          for (final json in jsonResponse['data']) {
            payment.add(PaymentDetailModel.fromJson(json));
          }
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: 'No Internet Connection');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something Went Wrong');
    }
    return payment;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
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
            SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<String>(
                    initialData: 'waiting',
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      return Text(
                        'total Out Standing : ${snapshot.requireData}',
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      );
                    }),
                FutureBuilder<List<PaymentDetailModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppProgressIndicator(
                          color: Palette.primaryColor);
                    }
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: (){
                          setState((){});
                         return getActivePayment();
                        },
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: payment.length,
                            itemBuilder: (context, index) {
                              final order = payment[index];
                              return Padding(
                                padding: EdgeInsets.all(20.w),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PaymentDetailPageById(id: order.id, partyName: order.name,))),
                                  child: Card(
                                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                                    elevation: 20,
                                    shadowColor: Palette.primaryColor.shade50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${order.name}',
                                              style: TextStyle(fontSize: 18.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
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
                                              const Text('Pending Amount',style: TextStyle(color: Colors.red),),
                                              Text('${order.pending}',style: TextStyle(color: Colors.red),)
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
                                              Text(DateFormat(
                                                      "dd-MM-yyyy hh:mm a")
                                                  .format(DateTime.tryParse(
                                                          "${order.modified}") ??
                                                      DateTime.now())),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.w,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await showCupertinoDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'Going To Pick The Payment'),
                                                            actions: [
                                                              TextButton(
                                                                child: const Text(
                                                                    'Yes'),
                                                                onPressed: () {
                                                                  _paymentPick(
                                                                      order);
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                  setState(() {});
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: const Text(
                                                                    'No'),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        false),
                                                              ),
                                                            ],
                                                          ));
                                                },
                                                child: order.assigned == 'y'
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Utils.showToast(
                                                              'Payment is assigned to someone please choose another payment');
                                                        },
                                                        child: Text(
                                                            'Going To Pick',
                                                            style: TextStyle(
                                                                color: Palette
                                                                    .primaryColor
                                                                    .shade900)))
                                                    : Text(
                                                        'Going To Pick',
                                                        style: TextStyle(
                                                            color: Palette
                                                                .primaryColor
                                                                .shade900),
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
                            }),
                      );
                    } else {
                      return const Center(
                        child: Text("Data not found"),
                      );
                    }
                  },
                  future: getActivePayment(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _paymentPick(PaymentDetailModel order) async {
    var data = <String, dynamic>{
      "party_id": order.id.toString(),
      "user_id": kUserdata?.id.toString(),
    };
    final response = await http.post(
        Uri.https('textileutsav.com', 'machine/api/mark-payment-going-to-pick'),
        body: data);

    try {
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Utils.showToast(jsonData['message']);
      }
    } catch (_) {
      Utils.showToast('Something Went Wrong');
    }
  }
}
