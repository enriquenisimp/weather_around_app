class ApiError {
  final int code;
  final String message;

  ApiError(this.code, this.message);

  static ApiError fromJson(Map<String, dynamic> json) => ApiError(
        json['code'] ?? 1000,
        json['message'] ?? "Something went wrong",
      );
}
