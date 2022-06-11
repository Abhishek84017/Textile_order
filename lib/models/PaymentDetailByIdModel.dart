
class PaymentDetailByIdModel {
  int? id;
  int? partyId;
  String? name;
  String? billNumber;
  String? date;
  int? billAmount;
  int? received;
  int? pending;
  int? days;
  String? assigned;
  dynamic employeeId;
  dynamic lastPaymentCollected;
  String? inserted;
  int? insertedBy;
  dynamic modified;
  dynamic modifiedBy;
  String? closed;

  PaymentDetailByIdModel(
      {this.id,
        this.partyId,
        this.name,
        this.billNumber,
        this.date,
        this.billAmount,
        this.received,
        this.pending,
        this.days,
        this.assigned,
        this.employeeId,
        this.lastPaymentCollected,
        this.inserted,
        this.insertedBy,
        this.modified,
        this.modifiedBy,
        this.closed});

  PaymentDetailByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyId = json['party_id'];
    name = json['name'];
    billNumber = json['bill_number'];
    date = json['date'];
    billAmount = json['bill_amount'];
    received = json['received'];
    pending = json['pending'];
    days = json['days'];
    assigned = json['assigned'];
    employeeId = json['employee_id'];
    lastPaymentCollected = json['last_payment_collected'];
    inserted = json['inserted'];
    insertedBy = json['inserted_by'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    closed = json['closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['party_id'] = partyId;
    data['name'] = name;
    data['bill_number'] = billNumber;
    data['date'] = date;
    data['bill_amount'] = billAmount;
    data['received'] = received;
    data['pending'] = pending;
    data['days'] = days;
    data['assigned'] = assigned;
    data['employee_id'] = employeeId;
    data['last_payment_collected'] = lastPaymentCollected;
    data['inserted'] = inserted;
    data['inserted_by'] = insertedBy;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['closed'] = closed;
    return data;
  }
}
