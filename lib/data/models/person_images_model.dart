import 'package:tmdb/data/models/images_model.dart';

class PersonImagesModel {
  int? id;
  List<ImageModel>? imagesModel;

  PersonImagesModel({this.id, this.imagesModel});

  PersonImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      imagesModel = <ImageModel>[];
      json['profiles'].forEach((v) {
        imagesModel!.add(new ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.imagesModel != null) {
      data['profiles'] = this.imagesModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
