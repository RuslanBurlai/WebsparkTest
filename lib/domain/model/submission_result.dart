import 'package:webspark_test/domain/model/result.dart';

class SubmissionResult {
  final String id;
  final Result result;

  SubmissionResult(this.id, this.result);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'result': result.toMap(),
    };
  }
}
