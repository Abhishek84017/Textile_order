import 'package:textile/models/models.dart';

class OrderDetailModel {
  OrderModel? order;
  List<OrderDesignModel>? orderDesign;

  OrderDetailModel({this.order, this.orderDesign});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = OrderModel.fromJson(json['order']);
    }
    if (json['orderDesign'] != null) {
      orderDesign = <OrderDesignModel>[];
      for (final v in json['orderDesign']) {
        orderDesign!.add(OrderDesignModel.fromJson(v));
      }
    }
  }
}