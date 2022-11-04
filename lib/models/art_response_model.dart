import 'dart:convert';

ArtResponseModel artResponseJson(String str) =>
    ArtResponseModel.fromJson(json.decode(str));

class ArtResponseModel {
  String? generated;

  ArtResponseModel({this.generated});

  ArtResponseModel.fromJson(Map<String, dynamic> json) {
    generated = json['generated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated'] = generated;
    return data;
  }
}
