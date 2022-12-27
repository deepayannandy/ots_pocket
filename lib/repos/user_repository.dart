import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/config/app_constants/api_endpoint.dart';
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class UserRepository {
  RestClient? restClient;

  UserRepository({this.restClient});

  Future<String> registerUser({required UserRegistration userDetails}) async {
    String endpoint = APIEndpoint.ENDPOINT_POST_USER_REGISTRATION;

    Response response =
        await restClient?.post(endpoint: endpoint, body: userDetails);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user registered successfully";
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<UserDetails>> getUserDetails() async {
    String endpoint = APIEndpoint.ENDPOINT_GET_USER_DETAILS;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<UserDetails> userDetailsList = json
          .decode(response.body)
          .map<UserDetails>((json) => UserDetails.fromJson(json))
          .toList();
      return userDetailsList;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  //by deep
  Future<UserDetails> getMyDetails() async {
    String endpoint = APIEndpoint.ENDPOINT_GET_MY_DETAILS;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Tutorial.fromJson(jsonDecode(nestedObjText));
      UserDetails myDetails = UserDetails.fromJson(jsonDecode(response.body));
      // .decode(response.body)
      // .map<UserDetails>((json) => UserDetails.fromJson(json));
      return myDetails;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // patch user
  Future<String> patchUser({required UserApprovalDetails userDetails}) async {
    String endpoint =
        APIEndpoint.ENDPOINT_PATCH_USER_DETAILS + userDetails.sId.toString();
    print(userDetails.sId.toString());

    Response response =
        await restClient?.patch(endpoint: endpoint, body: userDetails);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user patch successfully";
    } else {
      log("User patch repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // patch user
  Future<String> deleteUser({required String userid}) async {
    String endpoint = APIEndpoint.ENDPOINT_PATCH_USER_DELETION + userid;

    Response response = await restClient?.delete(endpoint: endpoint);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user deletion successfully";
    } else {
      log("User patch repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
