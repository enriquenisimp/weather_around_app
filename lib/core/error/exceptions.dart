class ServerException implements Exception{

  @override
  String toString() {
    return "Server Error";
  }
}
class NoInternetConnection implements Exception{

  @override
  String toString() {
    return "No internet connection";
  }
}
class ErrorFormattingData implements Exception{

  @override
  String toString() {
    return "The data provided by backend is not well formatted";
  }
}