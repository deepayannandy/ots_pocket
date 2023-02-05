import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:ots_pocket/config/app_constants/api_endpoint.dart';
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/labor_rate_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';

class LaborRateRepository {
  RestClient? restClient;

  LaborRateRepository({this.restClient});

  Future<String> addEquipment({required equipmentsDetails EquipDetails}) async {
    String endpoint = APIEndpoint.ENDPOINT_POST_NEW_EQUIPMENTS;

    Response response =
        await restClient?.post(endpoint: endpoint, body: EquipDetails);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user registered successfully";
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<LaborRate>> getLaborRate({required String catagory}) async {
    String endpoint = APIEndpoint.ENDPOINT_GET_ALL_LaborRate + catagory;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<LaborRate> alldesig = json
          .decode(response.body)
          .map<LaborRate>((json) => LaborRate.fromJson(json))
          .toList();
      return alldesig;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  //by deep
  Future<equipmentsDetails> getSpecificEquipments({required String Cid}) async {
    String endpoint = APIEndpoint.ENDPOINT_GET_SPECIFIC_EQUIPMENTS + Cid;

    Response response = await restClient?.get(
      endpoint: endpoint,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Tutorial.fromJson(jsonDecode(nestedObjText));
      equipmentsDetails equipment =
          equipmentsDetails.fromJson(jsonDecode(response.body));
      // .decode(response.body)
      // .map<UserDetails>((json) => UserDetails.fromJson(json));
      return equipment;
    } else {
      log("User registration repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // patch consumable
  Future<String> patchEquipment({required equipmentsDetails equipment}) async {
    String endpoint =
        APIEndpoint.ENDPOINT_PATCH_UPDATE_EQUIPMENTS + equipment.eId.toString();
    //print(userDetails.sId.toString());

    Response response =
        await restClient?.patch(endpoint: endpoint, body: equipment);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "user patch successfully";
    } else {
      log("User patch repo --> ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
