import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:textile/models/models.dart';
import 'package:textile/screens/widgets/order_row_status_dialog.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';
import 'package:textile/screens/widgets/gap.dart';
import 'package:textile/utils/services/rest_api.dart';

import '../../utils/palette.dart';
import '../widgets/drawer.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      drawer: const DrawerWidget(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: FutureBuilder<Data<OrderDetailModel>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AppProgressIndicator();
                }
                if (snapshot.hasData && snapshot.data!.statusCode == 200) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemBuilder: (context, index) {
                      return _card(snapshot.data!.data!.orderDesign![index],
                          snapshot.data!.data!.order);
                    },
                    itemCount: snapshot.data!.data!.orderDesign!.length,
                  );
                } else {
                  return const Center(
                    child: Text("Data not found"),
                  );
                }
              },
              future: Services.getOrderDetail(widget.order.id!),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _card(OrderDesignModel orderDesign, OrderModel? order) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 7.h),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.center,
          child: Text(
            "Design No.: ${orderDesign.designCode}(${orderDesign.rowNumber})",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(10),
        Card(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Number',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${order?.orderNumber}',style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 7.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Customer Name',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${order?.customerName}',style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(
                  height: 7.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Status',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${order?.status}',style:  TextStyle(fontWeight: FontWeight.bold,color: order?.status == 'pending' ? Colors.yellow : order?.status == 'running' ? Colors.orange : order?.status == 'hold' ? Colors.red : order?.status == 'completed' ? Colors.green : Colors.blue,),)
                  ],
                ),
                SizedBox(
                  height: 7.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Date',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.tryParse("${order?.orderDate}") ?? DateTime.now()),style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 20.w,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          separatorBuilder: (_, index) => SizedBox(height: 10.h),
          itemBuilder: (_, index) {
            final row = orderDesign.rows![index];
            return GestureDetector(
              onTap: () => _changeStatus(row),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Warp Color - \n" + row.warpColorCode!,
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Pick On Loom - " + orderDesign.pickOnLoom!,
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Average Pick - " +
                                    orderDesign.noOfFeeder.toString(),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "No Of Feeder - " +
                                    orderDesign.noOfFeeder.toString(),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Remarks - " + (row.remark ?? ''),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "particular - " + (row.particular ?? ''),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Rate - " + (row.rate ?? ''),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "particular - " + row.qty.toString(),
                                textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      if (row.items != null && row.items!.isNotEmpty)
                        for (int i = 0; i < row.items!.length; i++) ...[
                          Table(
                            border: TableBorder.all(color: Colors.black),
                            columnWidths: const {1: FlexColumnWidth(5.0)},
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "F${i + 1}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "${row.items![i].colorRemark}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: orderDesign.rows!.length,
        ),
      ],
    );
  }



  /// Change status of the row
  void _changeStatus(RowModel row) async {
    final data = await showCupertinoDialog(
      context: context,
      builder: (_) => OrderRowStatusDialog(row: row),
      barrierDismissible: true,
    );
    if (data is bool) {
      setState(() {});
    }
  }
}
