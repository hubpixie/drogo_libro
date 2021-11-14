import 'package:drogo_libro/core/enums/http_status.dart';

class DataResult<T> {
  DataResult({this.errorCode, this.message, this.result});

  int? errorCode;
  dynamic message;
  T? result;

  bool get hasError => ((this.errorCode ?? 0) >= HttpStatus.badRequest);
  bool get isNotFound => (this.errorCode == HttpStatus.notFound);
  bool get hasData {
    if (this.result == null || this.errorCode == HttpStatus.notFound) {
      return false;
    }
    bool ret = true;
    if (result != null && result is List) {
      List<dynamic> data = this.result as List<dynamic>;
      ret = data.isNotEmpty;
    }
    return ret;
  }

  DataResult.success(int code, T? result) {
    this.errorCode = code;
    this.result = result;
  }

  DataResult.error(int code, dynamic message) {
    this.errorCode = code;
    this.message = message;
  }
}
