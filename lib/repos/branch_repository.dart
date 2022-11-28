import 'dart:convert';

import 'package:http/http.dart';
import 'package:ots_pocket/config/app_constants/api_endpoint.dart';
import 'package:ots_pocket/config/rest_client.dart';
import 'package:ots_pocket/models/branch_model.dart';

class BranchRepository {
  RestClient? restClient;

  BranchRepository({this.restClient});

  Future<List<Branch>> getBranchDetails() async {
    String endpoint = APIEndpoint.ENDPOINT_GET_BRANCH;

    Response response = await restClient?.get(endpoint: endpoint);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Branch> branchList = json
          .decode(response.body)
          .map<Branch>((json) => Branch.fromJson(json))
          .toList();
      return branchList;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
