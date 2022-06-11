class PaymentDetailModel {
  int? id;
  String? name;
  dynamic mobile;
  dynamic email;
  dynamic address;
  dynamic remark;
  String? status;
  String? assigned;
  dynamic inserted;
  dynamic modified;
  dynamic insertedBy;
  dynamic modifiedBy;
  String? billAmount;
  String? received;
  String? pending;

  PaymentDetailModel(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.remark,
        this.status,
        this.assigned,
        this.inserted,
        this.modified,
        this.insertedBy,
        this.modifiedBy,
        this.billAmount,
        this.received,
        this.pending});

  PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    remark = json['remark'];
    status = json['status'];
    assigned = json['assigned'];
    inserted = json['inserted'];
    modified = json['modified'];
    insertedBy = json['inserted_by'];
    modifiedBy = json['modified_by'];
    billAmount = json['bill_amount'];
    received = json['received'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['remark'] = remark;
    data['status'] = status;
    data['assigned'] = assigned;
    data['inserted'] = inserted;
    data['modified'] = modified;
    data['inserted_by'] = insertedBy;
    data['modified_by'] = modifiedBy;
    data['bill_amount'] = billAmount;
    data['received'] = received;
    data['pending'] = pending;
    return data;
  }
}