import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ai_art_generator/config/index.dart';
import 'package:ai_art_generator/models/art_request_model.dart';
import 'package:ai_art_generator/models/art_response_model.dart';

class ArtService {
  static var client = http.Client();

  static Future<ArtResponseModel> requestPrompt(
    ArtRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };

    var url = Uri.http(
      Config.apiURL,
      "",
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return artResponseJson(response.body);
  }
}
