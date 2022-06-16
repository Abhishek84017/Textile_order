
class GalleryModel {
  String? code;
  String? image;

  GalleryModel({this.code, this.image});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> GalleryModel = <String, dynamic>{};
    GalleryModel['code'] = code;
    GalleryModel['image'] = image;
    return GalleryModel;
  }
}