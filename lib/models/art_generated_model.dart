import 'dart:convert';

ArtGeneratedModel artGeneratedJson(String str) =>
    ArtGeneratedModel.fromJson(json.decode(str));

class ArtGeneratedModel {
  String? email;
  List<String>? imageUrl;

  ArtGeneratedModel({this.email, this.imageUrl});

  ArtGeneratedModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    imageUrl = json['imageUrl'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
