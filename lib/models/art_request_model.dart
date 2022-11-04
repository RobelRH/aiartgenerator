class ArtRequestModel {
  String? prompt;

  ArtRequestModel({this.prompt});

  ArtRequestModel.fromJson(Map<String, dynamic> json) {
    prompt = json['prompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prompt'] = prompt;
    return data;
  }
}
