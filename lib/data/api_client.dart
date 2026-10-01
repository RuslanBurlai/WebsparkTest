import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webspark_test/data/model/api_response.dart';

abstract interface class ApiClient {

  Future<ApiResponse> get(
    String endpoint, {
    Map<String, String>? query,
  });

  Future<ApiResponse> post(
    String endpoint, {
    Object? body,
  });

  Future<ApiResponse> put(
    String endpoint, {
    Object? body,
  });

  Future<ApiResponse> delete(
    String endpoint,
  );
}

class HttpApiClientImpl implements ApiClient {
  final http.Client _client;

  HttpApiClientImpl({
    http.Client? client,
  }) : _client = client ?? http.Client();

  static const _timeout = Duration(seconds: 30);

  @override
  Future<ApiResponse> get(
    String endpoint, {
    Map<String, String>? query,
  }) {
    return _send(
      method: 'GET',
      endpoint: endpoint,
      query: query,
    );
  }

  @override
  Future<ApiResponse> post(
    String endpoint, {
    Object? body,
  }) {
    return _send(
      method: 'POST',
      endpoint: endpoint,
      body: body,
    );
  }

  @override
  Future<ApiResponse> put(
    String endpoint, {
    Object? body,
  }) {
    return _send(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
    );
  }

  @override
  Future<ApiResponse> delete(String endpoint) {
    return _send(
      method: 'DELETE',
      endpoint: endpoint,
    );
  }

  Future<ApiResponse> _send({
    required String method,
    required String endpoint,
    Map<String, String>? query,
    Object? body,
  }) async {
    final uri = Uri.parse(endpoint).replace(
      queryParameters: query,
    );

    final request = http.Request(method, uri);

    request.headers.addAll(await _createHeaders());

    if (body != null) {
      request.body = jsonEncode(body);
    }

    try {
      final streamedResponse = await _client.send(request).timeout(_timeout);

      final response = await http.Response.fromStream(streamedResponse);

      return ApiResponse.fromJson(response.body);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, String>> _createHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
