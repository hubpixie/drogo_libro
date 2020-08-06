class HttpStatus {
  /// 200 .. 299
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  /// 300 .. 399
  static const int notModified = 304;
  /// 400 .. 499
  static const int badRequest = 400;  
  static const int notFound = 404;  
  static const int requestTimeout = 408;  
  /// 500 .. 599
  static const int serverError = 500;  
  static const int gatewayTimeout = 504;  
  /// 900 .. 999
  static const int otherError = 990;  
  static const int unkwnown = 991;  
  static const int netoorkError = 992;  
}