import 'package:drogo_libro/core/enums/http_status.dart';
class DataResult<T>{
  DataResult({this.code, this.message, this.result});

  int code;
  dynamic message;
  T result;

  bool get hasError => (this.code >= HttpStatus.badRequest);
  bool get isNotFound => (this.code == HttpStatus.notFound);
  bool get hasData {
    if (this.result == null || this.code == HttpStatus.notFound) {
      return false;
    }
    bool ret = true;
    if (result is List) {
      List<dynamic> data = this.result as List<dynamic>;
      ret = data.isNotEmpty;
    }
    return ret;
  }

  DataResult.success(int code, T result) {
    this.code = code;
    this.result = result;
  }
  DataResult.error(int code, dynamic message) {
    this.code = code;
    this.message = message;
  }
}
