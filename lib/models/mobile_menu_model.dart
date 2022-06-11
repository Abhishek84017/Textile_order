class MenusModel {
  int? id;
  String? title;
  String? text;
  String? link;
  String? icon;
  String? status;
  String? insertedBy;
  String? inserted;
  String? modified;
  String? modifiedBy;
  int? position;
  int? parentId;
  List<MenusModel>? child;

  MenusModel(
      {this.id,
        this.title,
        this.text,
        this.link,
        this.icon,
        this.status,
        this.insertedBy,
        this.inserted,
        this.modified,
        this.modifiedBy,
        this.position,
        this.parentId,
        this.child});

  MenusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    link = json['link'];
    icon = json['icon'];
    status = json['status'];
    insertedBy = json['inserted_by'];
    inserted = json['inserted'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    position = json['position'];
    parentId = json['parent_id'];
    if (json['child'] != null) {
      child = <MenusModel>[];
      json['child'].forEach((v) {
        child!.add(MenusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    data['link'] = link;
    data['icon'] = icon;
    data['status'] = status;
    data['inserted_by'] = insertedBy;
    data['inserted'] = inserted;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['position'] = position;
    data['parent_id'] = parentId;
    if (child != null) {
      data['child'] = child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}