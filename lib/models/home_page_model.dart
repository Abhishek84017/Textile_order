

class HomePageModel {
  int? id;
  String? type;
  String? value;
  String? title;
  String? image;
  String? status;
  String? inserted;
  int? insertedBy;
  String? modified;
  String? modifiedBy;

  HomePageModel(
      {this.id,
        this.type,
        this.value,
        this.title,
        this.image,
        this.status,
        this.inserted,
        this.insertedBy,
        this.modified,
        this.modifiedBy});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    inserted = json['inserted'];
    insertedBy = json['inserted_by'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> HomePageModel = <String, dynamic>{};
    HomePageModel['id'] = id;
    HomePageModel['type'] = type;
    HomePageModel['value'] = value;
    HomePageModel['title'] = title;
    HomePageModel['image'] = image;
    HomePageModel['status'] = status;
    HomePageModel['inserted'] = inserted;
    HomePageModel['inserted_by'] = insertedBy;
    HomePageModel['modified'] = modified;
    HomePageModel['modified_by'] = modifiedBy;
    return HomePageModel;
  }
}