import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:ots_pocket/config/app_constants/api_endpoint.dart';
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/login_model.dart';

class LoginRepository {
  RestClient? restClient;

  LoginRepository({this.restClient});

  Future<String> login({required Login loginDetails}) async {
    String endpoint = APIEndpoint.ENDPOINT_POST_LOGIN;

    Response response =
        await restClient?.post(endpoint: endpoint, body: loginDetails);

    if (response.statusCode == 200 || response.statusCode == 201) {
      appStorage?.saveEncryptedData('token', response.body);
      return "login successfully";
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
