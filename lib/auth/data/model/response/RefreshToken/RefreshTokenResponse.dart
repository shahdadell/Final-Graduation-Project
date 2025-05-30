// ignore_for_file: file_names

class RefreshTokenResponse {
  String? status;
  String? accessToken;
  int? expiresIn;

  RefreshTokenResponse({this.status, this.accessToken, this.expiresIn});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      status: json['status'] as String?,
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'access_token': accessToken,
        'expires_in': expiresIn,
      };
}
