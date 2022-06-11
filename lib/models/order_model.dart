class OrderModel {
  int? id;
  int? orderNumber;
  int? customerId;
  String? orderDate;
  String? status;
  String? inserted;
  int? insertedBy;
  String? modified;
  int? modifiedBy;
  String? customerName;

  OrderModel(
      {this.id,
        this.orderNumber,
        this.customerId,
        this.orderDate,
        this.status,
        this.inserted,
        this.insertedBy,
        this.modified,
        this.modifiedBy,this.customerName});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    customerId = json['customer_id'];
    orderDate = json['order_date'];
    status = json['status'];
    inserted = json['inserted'];
    insertedBy = json['inserted_by'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['customer_id'] = customerId;
    data['order_date'] = orderDate;
    data['status'] = status;
    data['inserted'] = inserted;
    data['inserted_by'] = insertedBy;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['customer_name'] =customerName;
    return data;
  }
}
