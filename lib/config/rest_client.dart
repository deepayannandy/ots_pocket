import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ots_pocket/config/app_constants/url_prefix.dart';
import 'package:ots_pocket/main.dart';
import 'package:retry/retry.dart';

class RestClient {
  http.Client? _httpClient;
  RetryOptions? _retryOption;

  RestClient._internal();

  static final RestClient _instance = RestClient._internal();
  static final int _TIME_OUT_DURATION_IN_MINUTE = 5;

  factory RestClient(
      {required http.Client httpClient, required RetryOptions retryOption}) {
    _instance._httpClient = httpClient;
    _instance._retryOption = retryOption;
    return _instance;
  }

  Future<dynamic> get(
      {required String endpoint, Map<String, String>? queryParam}) async {
    try {
      var headers = await _getHeaderConfig();
      return await _retryOption?.retry(
        () => _httpClient
            ?.get(_getUri(queryParam, endpoint), headers: headers)
            .timeout(Duration(minutes: _TIME_OUT_DURATION_IN_MINUTE)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } on Exception catch (e) {
      log("RestClient - Exception : ${e.toString()}");
    }
  }

  Future<dynamic> post(
      {required String endpoint,
      Map<String, String>? queryParam,
      dynamic body}) async {
    try {
      var headers = await _getHeaderConfig();

      return await _httpClient
          ?.post(
            _getUri(queryParam, endpoint),
            headers: headers,
            body: (body != null) ? jsonEncode(body) : '',
          )
          .timeout(Duration(minutes: _TIME_OUT_DURATION_IN_MINUTE));
    } on Exception catch (e) {
      log("RestClient - Exception : ${e.toString()}");
    }
  }

  Future<dynamic> put(
      {required String endpoint,
      Map<String, String>? queryParam,
      dynamic body}) async {
    try {
      var headers = await _getHeaderConfig();

      return await _httpClient
          ?.put(
            _getUri(queryParam, endpoint),
            headers: headers,
            body: (body != null) ? jsonEncode(body) : '',
          )
          .timeout(Duration(minutes: _TIME_OUT_DURATION_IN_MINUTE));
    } on Exception catch (e) {
      log("RestClient - Exception : ${e.toString()}");
    }
  }

  Future<dynamic> patch(
      {required String endpoint,
      Map<String, String>? queryParam,
      dynamic body}) async {
    try {
      var headers = await _getHeaderConfig();
      print("test:" + endpoint + queryParam.toString());

      return await _httpClient
          ?.patch(
            _getUri(queryParam, endpoint),
            headers: headers,
            body: (body != null) ? jsonEncode(body) : '',
          )
          .timeout(Duration(minutes: _TIME_OUT_DURATION_IN_MINUTE));
    } on Exception catch (e) {
      log("RestClient - Exception : ${e.toString()}");
    }
  }

  Future<dynamic> delete(
      {required String endpoint, Map<String, String>? queryParam}) async {
    try {
      var headers = await _getHeaderConfig();
      return await _retryOption?.retry(
        () => _httpClient
            ?.delete(_getUri(queryParam, endpoint), headers: headers)
            .timeout(Duration(minutes: _TIME_OUT_DURATION_IN_MINUTE)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } on Exception catch (e) {
      log("RestClient - Exception : ${e.toString()}");
    }
  }

  Future<Map<String, String>> _getHeaderConfig() async {
    String? token = await appStorage?.retrieveEncryptedData('token');
    Map<String, String> headers = {};
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("auth-token", () => '$token');
    }
    return headers;
  }

  Uri _getUri(Map<String, String>? queryParam, String endpoint) {
    Uri uri = Uri.http(UrlPrefix.API_URL, endpoint, queryParam);
    log('uri' + uri.toString());
    return uri;
  }
}
