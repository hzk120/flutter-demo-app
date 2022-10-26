class LoginRequestModel {
  LoginRequestModel({
    required this.userName,
    required this.password,
  });

  final String userName;
  String password;

  Map<String, String> toJson() => {
        "userId": userName,
        "password": password,
      };
}

class LoginResponseModel {
  LoginResponseModel(
      {required this.status, required this.message, required this.data});

  final String status;
  final String message;
  final LoginResponseDataModel? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
          status: json["status"],
          message: json["message"],
          data: LoginResponseDataModel.fromJson(json["data"]));
}

class LoginResponseDataModel {
  LoginResponseDataModel(
      {required this.userId, required this.userName, required this.jwtToken});

  final String userId;
  final String userName;
  final String jwtToken;

  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseDataModel(
          userId: json["userId"],
          userName: json["userName"],
          jwtToken: json["jwtToken"]);
}
