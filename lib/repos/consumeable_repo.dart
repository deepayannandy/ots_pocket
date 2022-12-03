import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:ots_pocket/config/app_constants/api_endpoint.dart';
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';

class ConsumableRepository {
  RestClient? restClient;

  ConsumableRepository({this.restClient});

  Future<String> addConsumeables(
      {required ConsumeablesDetails ConDetails}) async {
    String endpoint = APIEndpoint.ENDPOINT_POST_NEW_CONSUMEABLES;

    Response response =
        await restClient?.post(endpoint: endpoint, body: ConDetails);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "successfully Added";
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<ConsumeablesDetails>> getConsumeabless() async {
    String endpoint = APIEndpoint.ENDPOINT_GET_ALL_CONSUMEABLES;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<ConsumeablesDetails> allConsumeales = json
          .decode(response.body)
          .map<ConsumeablesDetails>(
              (json) => ConsumeablesDetails.fromJson(json))
          .toList();
      return allConsumeales;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  //by deep
  Future<ConsumeablesDetails> getSpecificConsumeable(
      {required String Cid}) async {
    String endpoint = APIEndpoint.ENDPOINT_GET_MY_DETAILS + Cid;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Tutorial.fromJson(jsonDecode(nestedObjText));
      ConsumeablesDetails consumeable =
          ConsumeablesDetails.fromJson(jsonDecode(response.body));
      // .decode(response.body)
      // .map<UserDetails>((json) => UserDetails.fromJson(json));
      return consumeable;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // patch consumable
  Future<String> patchConsumeables(
      {required ConsumeablesDetails consumeable}) async {
    String endpoint = APIEndpoint.ENDPOINT_PATCH_UPDATE_CONSUMEABLES +
        consumeable.cId.toString();
    print(consumeable.cId.toString());

    Response response =
        await restClient?.patch(endpoint: endpoint, body: consumeable);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user patch successfully";
    } else {
      log("User patch repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
