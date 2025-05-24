class RefreshTokenResponse {
  final String? accessToken;
  final String? refreshToken;

  RefreshTokenResponse({this.accessToken, this.refreshToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
