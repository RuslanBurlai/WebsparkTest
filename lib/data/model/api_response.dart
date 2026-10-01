import 'dart:convert';

class ApiResponse {
  final bool error;
  final String message;
  final List<dynamic> body;
  ApiResponse({
    required this.error,
    required this.message,
    required this.body,
  });

  bool get isFailure => error;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'data': body,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      body: map['data'] as List<dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}