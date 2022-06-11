class OrderDesignModel {
  int? id;
  int? orderId;
  int? designId;
  int? rowNumber;
  String? designCode;
  String? pickOnLoom;
  String? averagePick;
  int? noOfFeeder;
  List<RowModel>? rows;

  OrderDesignModel(
      {this.id,
        this.orderId,
        this.designId,
        this.rowNumber,
        this.designCode,
        this.pickOnLoom,
        this.averagePick,
        this.noOfFeeder,
        this.rows});

  OrderDesignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    designId = json['design_id'];
    rowNumber = json['row_number'];
    designCode = json['design_code'];
    pickOnLoom = json['pick_on_loom'];
    averagePick = json['average_pick'];
    noOfFeeder = json['no_of_feeder'];
    if (json['rows'] != null) {
      rows = <RowModel>[];
      json['rows'].forEach((v) {
        rows!.add( RowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['design_id'] = designId;
    data['row_number'] = rowNumber;
    data['design_code'] = designCode;
    data['pick_on_loom'] = pickOnLoom;
    data['average_pick'] = averagePick;
    data['no_of_feeder'] = noOfFeeder;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RowModel {
  int? id;
  int? orderId;
  int? orderDesignId;
  int? rowNumber;
  String? warpColor;
  String? remark;
  String? particular;
  String? rate;
  int? qty;
  int? machineNumber;
  String? status;
  String? remarks;
  String? date;
  List<ItemsModel>? items;
  String? warpColorCode;

  RowModel(
      {this.id,
      this.orderId,
      this.orderDesignId,
      this.rowNumber,
      this.warpColor,
      this.remark,
      this.particular,
      this.rate,
      this.qty,
      this.machineNumber,
      this.status,
      this.remarks,
      this.date,
      this.items,
      this.warpColorCode});

  RowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderDesignId = json['order_design_id'];
    rowNumber = json['row_number'];
    warpColor = json['warp_color'];
    remark = json['remark'];
    particular = json['particular'];
    rate = json['rate'];
    qty = json['qty'];
    machineNumber = json['machine_number'];
    status = json['status'];
    remarks = json['remarks'];
    date = json['date'];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items!.add(ItemsModel.fromJson(v));
      });
    }
    warpColorCode = json['warp_color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['order_design_id'] = orderDesignId;
    data['row_number'] = rowNumber;
    data['warp_color'] = warpColor;
    data['remark'] = remark;
    data['particular'] = particular;
    data['rate'] = rate;
    data['qty'] = qty;
    data['machine_number'] = machineNumber;
    data['status'] = status;
    data['remarks'] = remarks;
    data['date'] = date;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['warp_color_code'] = warpColorCode;
    return data;
  }
}

class ItemsModel {
  int? id;
  int? orderId;
  int? rowId;
  int? partId;
  int? colorId;
  String? inserted;
  int? colNumber;
  String? colorCode;
  String? colorRemark;

  ItemsModel(
      {this.id,
      this.orderId,
      this.rowId,
      this.partId,
      this.colorId,
      this.inserted,
      this.colNumber,
      this.colorCode,
      this.colorRemark});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    rowId = json['row_id'];
    partId = json['part_id'];
    colorId = json['color_id'];
    inserted = json['inserted'];
    colNumber = json['col_number'];
    colorCode = json['color_code'];
    colorRemark = json['color_remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['row_id'] = rowId;
    data['part_id'] = partId;
    data['color_id'] = colorId;
    data['inserted'] = inserted;
    data['col_number'] = colNumber;
    data['color_code'] = colorCode;
    data['color_remark'] = colorRemark;
    return data;
  }
}
