class ApiError {
  final int code;
  final String message;

  ApiError(this.code, this.message);

  static ApiError? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return ApiError(
        json['error']['code'] ?? 1000,
        json['error']['message'] ?? "Something went wrong",
      );
    }
    return null;
  }
}
