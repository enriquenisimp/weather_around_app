enum ApiStatus {
  success(200),
  nameProvidedInvalidOrNull(401),
  invalidUrl(400),
  apiKeyDisabled(403);

  final int code;
  const ApiStatus(this.code);
}
