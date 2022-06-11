class UserModel {
  int? id;
  String? name;
  String? type;
  String? email;
  String? mobile;
  String? image;
  String? password;
  String? inserted;
  String? insertedBy;
  String? modified;
  String? modifiedBy;
  String? status;
  String? ins;
  String? del;
  String? modi;

  UserModel(
      {this.id,
      this.name,
      this.type,
      this.email,
      this.mobile,
      this.image,
      this.password,
      this.inserted,
      this.insertedBy,
      this.modified,
      this.modifiedBy,
      this.status,
      this.ins,
      this.del,
      this.modi});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    password = json['password'];
    inserted = json['inserted'];
    insertedBy = json['inserted_by'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    status = json['status'];
    ins = json['ins'];
    del = json['del'];
    modi = json['modi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = image;
    data['password'] = password;
    data['inserted'] = inserted;
    data['inserted_by'] = insertedBy;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['status'] = status;
    data['ins'] = ins;
    data['del'] = del;
    data['modi'] = modi;
    return data;
  }
}
