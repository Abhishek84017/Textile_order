

class NotesModel {
  String? title;
  String? image;

  NotesModel({this.title, this.image});

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> NotesModel = <String, dynamic>{};
    NotesModel['title'] = title;
    NotesModel['image'] = image;
    return NotesModel;
  }
}